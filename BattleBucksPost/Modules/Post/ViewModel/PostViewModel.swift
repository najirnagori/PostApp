//
//  PostViewModal.swift
//  BattleBucksPost
//
//  Created by Mohd on 03/10/25.
//

import Foundation
import Combine

class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var filteredPosts: [Post] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var isShowError: Bool = false
    @Published var errorMessage: String?
    
    private let networkService: NetworkServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    private let favoritesManager = FavoritesManager.shared
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
        setupSearch()
        loadPosts()
    }
    
    private func setupSearch() {
        $searchText
            .combineLatest($posts)
            .map { searchText, posts in
                guard !searchText.isEmpty else { return posts }
                return posts.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
            }
            .assign(to: &$filteredPosts)
    }
    
    func loadPosts() {
        isLoading = true
        errorMessage = nil
        isShowError = false
        
        networkService.fetchPosts()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = self?.errorMessage(for: error)
                    self?.isShowError = true
                }
            } receiveValue: { [weak self] posts in
                self?.posts = posts
            }
            .store(in: &cancellables)
    }
    
    func refreshPosts() {
        loadPosts()
    }
    
    func isFavorite(_ post: Post) -> Bool {
        favoritesManager.isFavorite(post)
    }
    
    func toggleFavorite(_ post: Post) {
        favoritesManager.toggleFavorite(post)
        objectWillChange.send()
    }
    
    private func errorMessage(for error: NetworkError) -> String {
        switch error {
        case .invalidURL:
            return "Invalid URL"
        case .requestFailed(let error):
            return "Request failed: \(error.localizedDescription)"
        case .decodingError:
            return "Failed to decode response"
        case .unknown:
            return "An unknown error occurred"
        }
    }
}

