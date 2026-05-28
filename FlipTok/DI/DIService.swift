//
//  DIService.swift
//  FlipTok
//
//  Created by Кирилл Казаков on 28.05.2026.
//

import Foundation

final class DIService {
    
    // MARK: - Properties
    
    let container = DIContainer.shared
    
    // MARK: - Initialization
    
    init() {}
    
    // MARK: - Internal Methods
    
    func registerDependencies() {
        registerServices()
        registerManagers()
    }
    
    // MARK: - Private Methods
    
    private func registerServices() {
        // TODO
    }
    
    private func registerManagers() {
        // TODO
    }
}
