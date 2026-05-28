//
//  AppDelegate.swift
//  FlipTok
//
//  Created by Кирилл Казаков on 28.05.2026.
//

import UIKit

final class AppDelegate: NSObject, UIApplicationDelegate {
    
    // Dependencies
    private lazy var diService = DIService()
    
    // MARK: - Internal Methods
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        diService.registerDependencies()
        
        return true
    }
}
