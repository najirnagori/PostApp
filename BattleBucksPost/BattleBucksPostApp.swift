//
//  BattleBucksPostApp.swift
//  BattleBucksPost
//
//  Created by Mohd on 03/10/25.
//

import SwiftUI

@main
struct BattleBucksPostApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                PostListView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Posts")
                    }
                
                FavoritesView()
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Favorites")
                    }
            }
            .accentColor(.blue)
        }
    }
}
