//
//  TabBarViewTabs.swift
//  FlipTok
//
//  Created by Кирилл Казаков on 26.05.2026.
//

import SwiftUI

enum TabBarViewTabs: CaseIterable, Identifiable {
    
    case feed
    case friends
    case makeContent
    case messages
    case profile
    
    // MARK: - Properties
    
    var id: Self { self }
    
    var tabName: LocalizedStringKey {
        switch self {
        case .feed:        "mainPage"
        case .friends:     "friends"
        case .makeContent: ""
        case .messages:    "messages"
        case .profile:     "profile"
        }
    }
    
    var tabIconName: String {
        switch self {
        case .feed:        "house"
        case .friends:     "person.2"
        case .makeContent: "plus.rectangle"
        case .messages:    "message"
        case .profile:     "person"
        }
    }
    
    // MARK: - UI
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .feed:        FeedView()
        case .friends:     FriendsView()
        case .makeContent: MakeContentView()
        case .messages:    MessagesView()
        case .profile:     ProfileView()
        }
    }
}
