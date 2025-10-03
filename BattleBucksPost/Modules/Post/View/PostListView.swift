//
//  PostListView.swift
//  BattleBucksPost
//
//  Created by Mohd on 03/10/25.
//

import SwiftUI

struct PostListView: View {
    @StateObject private var viewModel = PostViewModel()
    @State private var showingDetail: Post?
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText, placeholder: "Search posts by title...")
                
                if viewModel.filteredPosts.isEmpty {
                    noPostView
                } else {
                    postView
                }
            }
            .loaderView(isPresented: $viewModel.isLoading)
            .errorView(
                isShowError: $viewModel.isShowError,
                message: viewModel.errorMessage ?? "",
                retryAction: {
                viewModel.loadPosts()
            })
            .navigationTitle("Posts")
            .sheet(item: $showingDetail) { post in
                PostDetailView(post: post, isFavorite: viewModel.isFavorite(post)) {
                    viewModel.toggleFavorite(post)
                }
            }
            
        }
    }
}

#Preview {
    PostListView()
}


extension PostListView {
    
    private var noPostView: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: "apple.logo")
                .font(.system(size: 50))
                .foregroundColor(.secondary)
            
            Text("No Post Yet")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Wait for the Post to be added...")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
    }
    
    private var postView: some View {
        List {
            ForEach(viewModel.filteredPosts) { post in
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
        .refreshable {
            viewModel.refreshPosts()
        }
    }
}
