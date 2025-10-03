//
//  ErrorView.swift
//  BattleBucksPost
//
//  Created by Mohd on 03/10/25.
//

import SwiftUI

struct ErrorView: View {
    @Binding var isShowError: Bool
    let message: String
    let retryAction: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(isShowError ? 0.1 : 0)
                .ignoresSafeArea()
            VStack(spacing: 16) {
                Image(systemName: "exclamationmark.triangle")
                    .font(.system(size: 50))
                    .foregroundColor(.orange)
                
                Text("Oops!")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(message)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                HStack {
                    Button {
                        isShowError = false
                    } label: {
                        buttonText(text: "Okay")
                    }
                    
                    Button {
                        retryAction()
                    } label: {
                        buttonText(text: "Try Again")
                    }
                    
                }
            }
            .padding()
            .background(
                Color(.systemGray6)
            )
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

#Preview {
    ErrorView(isShowError: .constant(false), message: "Error", retryAction: {})
}


extension ErrorView {
    private func buttonText(text: String) -> some View {
        Text(text)
            .padding(.vertical, 8)
            .frame(width: 150)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
