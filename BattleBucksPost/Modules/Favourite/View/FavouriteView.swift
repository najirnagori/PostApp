//
//  FavouriteView.swift
//  BattleBucksPost
//
//  Created by Mohd on 03/10/25.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel = FavoritesViewModel()
    @State private var showingDetail: Post?
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.favoritePosts.isEmpty {
                    noDataView
                } else {
                    favouritePostList
                }
            }
            .navigationTitle("Favorites")
            .sheet(item: $showingDetail) { post in
                PostDetailView(post: post, isFavorite: viewModel.isFavorite(post)) {
                    viewModel.toggleFavorite(post)
                }
            }
        }
    }
}

#Preview {
    FavoritesView()
}

extension FavoritesView {
    private var noDataView: some View {
        VStack(spacing: 16) {
            Image(systemName: "heart.slash")
                .font(.system(size: 50))
                .foregroundColor(.secondary)
            
            Text("No Favorites Yet")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Mark posts as favorites to see them here.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
    
    private var favouritePostList: some View {
        List {
            ForEach(viewModel.favoritePosts) { post in
                PostRow(
                    post: post,
                    isFavorite: viewModel.isFavorite(post)
                ) {
                    viewModel.toggleFavorite(post)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    showingDetail = post
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}
