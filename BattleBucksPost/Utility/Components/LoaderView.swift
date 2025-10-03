//
//  LoaderView.swift
//  BattleBucksPost
//
//  Created by Mohd on 03/10/25.
//

import SwiftUI

struct LoaderView: View {
    
    @State private var animateOuterCircle: Bool = false
    @State private var animateInnerCircle: Bool = false
    @State private var shoLoader: Bool = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(shoLoader ? 0.1 : 0)
                .ignoresSafeArea()
            
            VStack {
                ZStack {
                    Circle()
                        .trim(from: 0, to: 0.9)
                        .stroke(Color.gray, lineWidth: 4)
                        .frame(width: 54, height: 54)
                        .rotationEffect(Angle(degrees: animateOuterCircle ? 360 : 0))
                    
                    Circle()
                        .trim(from: 0, to: 0.2)
                        .stroke(Color.red, lineWidth: 4)
                        .frame(width: 36, height: 36)
                        .rotationEffect(Angle(degrees: animateInnerCircle ? -360 : 0))
                }
            }
            .frame(width: 100, height: 100)
            .background(Color.white)
            .cornerRadius(16)
            .scaleEffect(shoLoader ? 1.0 : 2)
            .opacity(shoLoader ? 1 : 0)
            
        }
        .onAppear {
            withAnimation(.linear(duration: 1.0).repeatForever(autoreverses: false)) {
                animateOuterCircle = true
            }
            withAnimation(.linear(duration: 0.6).repeatForever(autoreverses: false)) {
                animateInnerCircle = true
            }
            withAnimation(.easeIn(duration: 0.4)) {
                shoLoader = true
            }
        }
        .onDisappear {
            withAnimation(.easeIn(duration: 0.5)) {
                shoLoader = false
            }
        }
    }
}

#Preview {
    LoaderView()
}
