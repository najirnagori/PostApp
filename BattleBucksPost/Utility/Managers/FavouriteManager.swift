//
//  FavouriteManager.swift
//  BattleBucksPost
//
//  Created by Mohd on 03/10/25.
//

import Foundation
import Combine

class FavoritesManager: ObservableObject {
    static let shared = FavoritesManager()
    
    @Published private(set) var favorites: [Int: Post] = [:]
    
    private let favoritesKey = "favorite_posts"
    
    private init() {
        loadFavorites()
    }
    
    func isFavorite(_ post: Post) -> Bool {
        favorites[post.id] != nil
    }
    
    func toggleFavorite(_ post: Post) {
        if isFavorite(post) {
            favorites.removeValue(forKey: post.id)
        } else {
            favorites[post.id] = post
        }
        saveFavorites()
    }
    
    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }
    
    private func loadFavorites() {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey),
              let decoded = try? JSONDecoder().decode([Int: Post].self, from: data) else {
            return
        }
        favorites = decoded
    }
}
