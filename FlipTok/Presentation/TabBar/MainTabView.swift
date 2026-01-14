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
    
    var index: Int {
        switch self {
        case .feed: 1
        case .friends: 2
        case .createVideo: 3
        case .messages: 4
        case .profile: 5
        }
    }
}

#Preview {
    MainTabView()
}

