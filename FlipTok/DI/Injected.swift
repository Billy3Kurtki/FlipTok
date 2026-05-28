//
//  Injected.swift
//  FlipTok
//
//  Created by Кирилл Казаков on 28.05.2026.
//

import Foundation

@propertyWrapper
struct Injected<T> {
    
    // MARK: - Properties
    
    let wrappedValue: T
    
    // MARK: - Initialization
    
    init() {
        self.wrappedValue = DIContainer.shared.resolve(T.self)
    }
}
