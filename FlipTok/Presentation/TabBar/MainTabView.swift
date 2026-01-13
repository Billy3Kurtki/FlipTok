//
//  MainTabView.swift
//  FlipTok
//
//  Created by Dima on 13.01.2026.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            FeedView()
                .tabItem {
                    Label("Главная", systemImage: "house.fill")
                }
            ShopView()
                .tabItem {
                    Label("Магазин", systemImage: "cart.badge.plus")
                }
            CreateVideoView()
                .tabItem {
                    Label("", systemImage: "plus.rectangle.fill")
                }
            MessagesView()
                .tabItem {
                    Label("Входящие", systemImage: "message.fill")
                }
            ProfileView()
                .tabItem {
                    Label("Профиль", systemImage: "person.fill")
                }
        }
    }
}

#Preview {
    MainTabView()
}

