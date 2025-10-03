//
//  PostDetailsView.swift
//  BattleBucksPost
//
//  Created by Mohd on 03/10/25.
//

import SwiftUI

struct PostDetailView: View {
    let post: Post
    let isFavorite: Bool
    let onFavoriteTapped: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text(post.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button(action: onFavoriteTapped) {
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .font(.title2)
                                .foregroundColor(isFavorite ? .red : .gray)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Content")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text(post.body)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Label("User ID: \(post.userId)", systemImage: "person")
                        Spacer()
                        Label("Post ID: \(post.id)", systemImage: "number")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}
