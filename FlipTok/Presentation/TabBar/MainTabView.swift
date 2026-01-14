//
//  MainTabView.swift
//  FlipTok
//
//  Created by Dima on 13.01.2026.
//

import SwiftUI

struct MainTabView: View {
    
    // MARK: - Properties
    
    @State private var selectedTab: Int = MainTabs.feed.index
    
    // MARK: - UI
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(MainTabs.allCases, id: \.self) { tab in
                tab.contentView
                    .tabItem {
                        VStack {
                            Image(systemName: tab.tabIconName)
                                .environment(\.symbolVariants, selectedTab == tab.index ? .fill : .none)
                            Text(tab.tabName)
                        }
                    }
                    .tag(tab.index)
            }
        }
        .tint(.black)
    }
}

// MARK: - MainTabs

enum MainTabs: CaseIterable {
    
    case feed
    case friends
    case createVideo
    case messages
    case profile
    
// MARK: - Properties
    
    @ViewBuilder
    var contentView: some View {
        switch self {
        case .feed: FeedView()
        case .friends: FriendsView()
        case .createVideo: CreateVideoView()
        case .messages: MessagesView()
        case .profile: ProfileView()
        }
    }
    
    var tabName: String {
        switch self {
        case .feed: return "Главная"
        case .friends: return "Друзья"
        case .createVideo: return ""
        case .messages: return "Сообщения"
        case .profile: return "Профиль"
        }
    }
    
    var tabIconName: String {
        switch self {
        case .feed: return "house"
        case .friends: return "person.2"
        case .createVideo: return "plus.rectangle"
        case .messages: return "message"
        case .profile: return "person"
        }
    }
    
    var index: Int {
        switch self {
        case .feed: return 1
        case .friends: return 2
        case .createVideo: return 3
        case .messages: return 4
        case .profile: return 5
        }
    }
}

#Preview {
    MainTabView()
}

