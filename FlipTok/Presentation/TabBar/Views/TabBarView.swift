//
//  TabBarView.swift
//  FlipTok
//
//  Created by Dima on 13.01.2026.
//

import SwiftUI

 private enum Const {
    
    static let tabItemVSpacing: CGFloat = 4
}

struct TabBarView: View {
    
    // MARK: - Properties
    
    @State private var selectedTab: TabBarViewTabs = .feed
    
    // MARK: - UI
    
    var body: some View {
        contentView
    }
    
    private var contentView: some View {
        TabView(selection: $selectedTab) {
            ForEach(TabBarViewTabs.allCases) { tab in
                tab.destination
                    .tabItem {
                        tabItemView(with: tab)
                    }
                    .tag(tab)
            }
        }
        .tint(.defaultBlack)
    }
    
    private func tabItemView(with tab: TabBarViewTabs) -> some View {
        VStack(alignment: .center, spacing: Const.tabItemVSpacing) {
            Image(systemName: tab.tabIconName)
                .environment(\.symbolVariants, selectedTab == tab ? .fill : .none)
            Text(tab.tabName)
        }
    }
}

#Preview {
    TabBarView()
}

