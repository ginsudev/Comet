//
//  Searchable+iOS14.swift
//  Comet
//
//  Created by Noah Little on 10/4/2023.
//

import SwiftUI

internal extension View {
    func compatSearchable(text: Binding<String>) -> some View {
        modifier(CompatSearchableViewModifier(text: text))
    }
}

private struct CompatSearchableViewModifier: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        if #available(iOS 15, *) {
            // Use good search bar on iOS >= 15.0
            content
                .searchable(text: $text)
        } else {
            // Use ugly search bar on iOS 14
            VStack {
                TextField("Search", text: $text)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                content
            }
        }
    }
}
