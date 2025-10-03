//
//  FavouriteViewModal.swift
//  BattleBucksPost
//
//  Created by Mohd on 03/10/25.
//

import Foundation
import Combine

class FavoritesViewModel: ObservableObject {
    @Published var favoritePosts: [Post] = []
    
    private let favoritesManager = FavoritesManager.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupFavoritesObserver()
    }
    
    private func setupFavoritesObserver() {
        favoritesManager.$favorites
            .map { Array($0.values).sorted { $0.id < $1.id } }
            .assign(to: &$favoritePosts)
    }
    
    func isFavorite(_ post: Post) -> Bool {
        favoritesManager.isFavorite(post)
    }
    
    func toggleFavorite(_ post: Post) {
        favoritesManager.toggleFavorite(post)
    }
}
