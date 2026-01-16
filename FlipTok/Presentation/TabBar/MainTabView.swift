//
//  MainTabView.swift
//  FlipTok
//
//  Created by Dima on 13.01.2026.
//

import SwiftUI

 private enum Const {
    
    static let tabItemVSpacing: CGFloat = 4
}

struct MainTabView: View {
    
    // MARK: - Properties
    
    @State private var selectedTab: MainTabs = .feed
    
    // MARK: - UI
    
    var body: some View {
        contentView
    }
    
    private var contentView: some View {
        TabView(selection: $selectedTab) {
            ForEach(MainTabs.allCases) { tab in
                tab.destination
                    .tabItem {
                        tabItemView(with: tab)
                    }
                    .tag(tab)
            }
        }
        .tint(.black)
    }
    
    private func tabItemView(with tab: MainTabs) -> some View {
        VStack(spacing: Const.tabItemVSpacing) {
            Image(systemName: tab.tabIconName)
                .environment(\.symbolVariants, selectedTab == tab ? .fill : .none)
            Text(tab.tabName)
        }
    }
}

// MARK: - MainTabs

enum MainTabs: CaseIterable, Identifiable {
    
    case feed
    case friends
    case createVideo
    case messages
    case profile
    
    // MARK: - Properties
    
    var id: MainTabs { self }
    
    var tabName: String {
        switch self {
        case .feed: "Главная"
        case .friends: "Друзья"
        case .createVideo: ""
        case .messages: "Сообщения"
        case .profile: "Профиль"
        }
    }
    
    var tabIconName: String {
        switch self {
        case .feed: "house"
        case .friends: "person.2"
        case .createVideo: "plus.rectangle"
        case .messages: "message"
        case .profile: "person"
        }
    }
    
    // MARK: - UI
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .feed: FeedView()
        case .friends: FriendsView()
        case .createVideo: CreateVideoView()
        case .messages: MessagesView()
        case .profile: ProfileView()
        }
    }
}

#Preview {
    MainTabView()
}

