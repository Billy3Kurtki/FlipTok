//
//  DIContainer.swift
//  FlipTok
//
//  Created by Кирилл Казаков on 28.05.2026.
//

import Foundation

final class DIContainer {
    
    // MARK: - Properties
    
    static let shared = DIContainer()
    
    private var services: [String: Any] = [:]
    private var factories: [String: () -> Any] = [:]
    
    
    // MARK: - Initialization
    
    private init() {}
    
    // MARK: - Internal Methods
    
    // Регистрация синглтона
    func register<T>(_ type: T.Type, instance: T) {
        let key = String(describing: type)
        services[key] = instance
    }
    
    // Регистрация фабрики (новый экземпляр при каждом запросе)
    func register<T>(_ type: T.Type, factory: @escaping () -> T) {
        let key = String(describing: type)
        factories[key] = factory
    }
    
    // Регистрация с протоколом и реализацией
    func register<T>(_ protocolType: T.Type, implementation: Any) {
        let key = String(describing: protocolType)
        services[key] = implementation
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        let key = String(describing: type)
        
        // Сначала проверяем синглтоны
        if let service = services[key] as? T {
            return service
        }
        
        // Затем проверяем фабрики
        if let factory = factories[key], let service = factory() as? T {
            return service
        }
        
        fatalError("No registered service for type \(type)")
    }
}
