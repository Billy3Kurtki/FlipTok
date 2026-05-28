//
//  FlipTokApp.swift
//  FlipTok
//
//  Created by Кирилл Казаков on 03.01.2026.
//

import SwiftUI

@main
struct FlipTokApp: App {
    
    // Dependencies
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    // MARK: - UI
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
