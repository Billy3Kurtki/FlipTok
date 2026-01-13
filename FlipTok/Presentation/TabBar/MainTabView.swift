//
//  MainTabView.swift
//  FlipTok
//
//  Created by Dima on 13.01.2026.
//

import SwiftUI

struct MainTabView: View {
    
    // MARK: - Properties
    
    @State private var selectedTab: Int = 1
    
    // MARK: - UI
    
    var body: some View {
        TabView(selection: $selectedTab) {
            FeedView()
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                            .environment(\.symbolVariants, selectedTab == 1 ? .fill : .none)
                        Text("Главная")
                    }
                }
                .tag(1)
            
            ShopView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.2")
                            .environment(\.symbolVariants, selectedTab == 2 ? .fill : .none)
                        Text("Друзья")
                    }
                }
                .tag(2)
            
            CreateVideoView()
                .tabItem {
                    VStack {
                        Image(systemName: "plus.rectangle")
                            .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                    }
                }
                .tag(3)
            
            MessagesView()
                .tabItem {
                    VStack {
                        Image(systemName: "message")
                            .environment(\.symbolVariants, selectedTab == 4 ? .fill : .none)
                        Text("Входящие")
                    }
                }
                .tag(4)
            
            ProfileView()
                .tabItem {
                    VStack {
                        Image(systemName: "person")
                            .environment(\.symbolVariants, selectedTab == 5 ? .fill : .none)
                        Text("Профиль")
                    }
                }
                .tag(5)
        }
        .tint(.black)
    }
}

#Preview {
    MainTabView()
}

