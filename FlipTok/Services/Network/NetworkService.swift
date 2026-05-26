//
//  NetworkService.swift
//  FlipTok
//
//  Created by Dima on 13.01.2026.
//

import Foundation

// MARK: - Network Errors

enum NetworkError: LocalizedError {
    
    case invalidURL
    case noData
    case decodingError(Error)
    case encodingError(Error)
    case serverError(statusCode: Int, message: String?)
    case custom(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Неверный URL"
        case .noData:
            return "Нет данных от сервера"
        case .decodingError(let error):
            return "Ошибка декодирования: \(error.localizedDescription)"
        case .encodingError(let error):
            return "Ошибка кодирования: \(error.localizedDescription)"
        case .serverError(let statusCode, let message):
            return "Ошибка сервера \(statusCode): \(message ?? "Неизвестная ошибка")"
        case .custom(let message):
            return message
        }
    }
}

// MARK: - HTTP Methods

enum HTTPMethod: String {
    
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

// MARK: - Network Service

final class NetworkService {
    
    // MARK: - Properties
    
    static let shared = NetworkService()
    
    private let session: URLSession
    private let jsonDecoder: JSONDecoder
    private let jsonEncoder: JSONEncoder
    private let enableLogging: Bool
    
    // MARK: - Initialization
    
    private init() {
        self.session = .shared
        self.jsonDecoder = JSONDecoder()
        self.jsonEncoder = JSONEncoder()
        self.enableLogging = true
        
        // Настройка дефолтных параметров
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        self.jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        self.jsonDecoder.dateDecodingStrategy = .iso8601
        self.jsonEncoder.dateEncodingStrategy = .iso8601
    }
    
    // MARK: - Internal Methods
    
    /// GET запрос
    func get<T: Decodable>(
        url: String,
        headers: [String: String]? = nil
    ) async throws -> T {
        return try await request(url: url, method: .get, headers: headers)
    }
    
    /// POST запрос с телом
    func post<T: Decodable, U: Encodable>(
        url: String,
        body: U,
        headers: [String: String]? = nil
    ) async throws -> T {
        return try await request(url: url, method: .post, body: body, headers: headers)
    }
    
    /// POST запрос без тела
    func post<T: Decodable>(
        url: String,
        headers: [String: String]? = nil
    ) async throws -> T {
        return try await request(url: url, method: .post, headers: headers)
    }
    
    /// PUT запрос
    func put<T: Decodable, U: Encodable>(
        url: String,
        body: U,
        headers: [String: String]? = nil
    ) async throws -> T {
        return try await request(url: url, method: .put, body: body, headers: headers)
    }
    
    /// DELETE запрос
    func delete<T: Decodable>(
        url: String,
        headers: [String: String]? = nil
    ) async throws -> T {
        return try await request(url: url, method: .delete, headers: headers)
    }
    
    /// Запрос с данными (для отправки изображений и т.д.)
    func upload<T: Decodable>(
        url: String,
        data: Data,
        method: HTTPMethod = .post,
        headers: [String: String]? = nil
    ) async throws -> T {
        var allHeaders = headers ?? [:]
        allHeaders["Content-Type"] = "application/octet-stream"
        
        return try await request(
            url: url,
            method: method,
            bodyData: data,
            headers: allHeaders
        )
    }
    
    /// Запрос для скачивания данных
    func download(url: String, headers: [String: String]? = nil) async throws -> Data {
        guard let request = makeRequest(url: url, method: .get, headers: headers) else {
            throw NetworkError.invalidURL
        }
        
        logRequest(request, body: nil)
        
        do {
            let (data, response) = try await session.data(for: request)
            try validateResponse(response, data: data)
            logResponse(response, data: data)
            return data
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.custom(error.localizedDescription)
        }
    }
    
    // MARK: - Private Core Method
    
    private func request<T: Decodable, U: Encodable>(
        url: String,
        method: HTTPMethod,
        body: U? = nil,
        headers: [String: String]? = nil
    ) async throws -> T {
        let bodyData: Data?
        if let body = body {
            do {
                bodyData = try jsonEncoder.encode(body)
            } catch {
                throw NetworkError.encodingError(error)
            }
        } else {
            bodyData = nil
        }
        
        return try await request(
            url: url,
            method: method,
            bodyData: bodyData,
            headers: headers
        )
    }
    
    private func request<T: Decodable>(
        url: String,
        method: HTTPMethod,
        bodyData: Data? = nil,
        headers: [String: String]? = nil
    ) async throws -> T {
        guard let request = makeRequest(url: url, method: method, bodyData: bodyData, headers: headers) else {
            throw NetworkError.invalidURL
        }
        
        logRequest(request, body: bodyData)
        
        do {
            let (data, response) = try await session.data(for: request)
            try validateResponse(response, data: data)
            logResponse(response, data: data)
            
            do {
                let result = try jsonDecoder.decode(T.self, from: data)
                return result
            } catch {
                throw NetworkError.decodingError(error)
            }
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.custom(error.localizedDescription)
        }
    }
    
    // MARK: - Request Builder
    
    private func makeRequest(
        url: String,
        method: HTTPMethod,
        bodyData: Data? = nil,
        headers: [String: String]? = nil
    ) -> URLRequest? {
        guard let url = URL(string: url) else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = bodyData
        
        // Set content type for JSON
        if bodyData != nil && headers?["Content-Type"] == nil {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        // Add custom headers
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
    
    // MARK: - Validation
    
    private func validateResponse(_ response: URLResponse, data: Data) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.custom("Неверный тип ответа")
        }
        
        let statusCode = httpResponse.statusCode
        
        switch statusCode {
        case 200...299:
            return
        default:
            let message = String(data: data, encoding: .utf8)
            throw NetworkError.serverError(statusCode: statusCode, message: message)
        }
    }
    
    // MARK: - Logging
    
    // TODO: Создать класс Logger и юзать его
    private func logRequest(_ request: URLRequest, body: Data?) {
        guard enableLogging else { return }
        
        print("\n📤 [REQUEST] \(request.httpMethod ?? "UNKNOWN") \(request.url?.absoluteString ?? "nil")")
        print("Headers: \(request.allHTTPHeaderFields ?? [:])")
        
        if let body = body, let bodyString = String(data: body, encoding: .utf8) {
            print("Body: \(bodyString)")
        }
    }
    
    private func logResponse(_ response: URLResponse, data: Data) {
        guard enableLogging else { return }
        
        if let httpResponse = response as? HTTPURLResponse {
            print("\n📥 [RESPONSE] \(httpResponse.statusCode) \(response.url?.absoluteString ?? "nil")")
        }
        
        if let dataString = String(data: data, encoding: .utf8) {
            let preview = dataString.count > 1000 ? String(dataString.prefix(1000)) + "..." : dataString
            print("Data: \(preview)")
        }
    }
}
