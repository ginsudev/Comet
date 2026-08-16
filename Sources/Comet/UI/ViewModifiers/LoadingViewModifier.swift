//
//  LoadingViewModifier.swift
//  Comet
//
//  Created by Noah Little on 10/4/2023.
//

import SwiftUI

internal extension View {
    func loading(_ isLoading: Bool, title: String) -> some View {
        modifier(
            LoadingViewModifier(
                isLoading: isLoading,
                title: title
            )
        )
    }
}

private struct LoadingViewModifier: ViewModifier {
    let isLoading: Bool
    let title: String
    
    func body(content: Content) -> some View {
        if isLoading {
            ZStack {
                content
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea()
                VStack {
                    Text(title)
                        .font(.title2)
                    ProgressView()
                }
            }
        } else {
            content
        }
    }
}
