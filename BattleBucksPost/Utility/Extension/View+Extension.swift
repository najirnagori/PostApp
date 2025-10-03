//
//  View+Extension.swift
//  BattleBucksPost
//
//  Created by Mohd on 03/10/25.
//

import SwiftUI

extension View {
    func loaderView(isPresented: Binding<Bool>) -> some View {
        self
            .overlay {
                if isPresented.wrappedValue == true {
                    LoaderView()
                }
            }
    }
    
    func errorView(isShowError: Binding<Bool>, message: String, retryAction: @escaping () -> Void) -> some View {
        self
            .overlay {
                if isShowError.wrappedValue == true {
                    ErrorView(isShowError: isShowError, message: message, retryAction: retryAction)
                }
            }
    }
    
    
}
