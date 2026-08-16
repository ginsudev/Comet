//
//  HexColorPicker.swift
//  Comet
//
//  Created by Noah Little on 7/4/2023.
//

import SwiftUI

// MARK: - Public

public struct HexColorPicker: View {
    @State private var selectedUnderlyingColor: Color
    
    @Binding var selectedColorHex: String
    let title: String
    
    public init(
        selectedColorHex: Binding<String>,
        title: String
    ) {
        self._selectedColorHex = selectedColorHex
        self._selectedUnderlyingColor = .init(wrappedValue: .init(hex: selectedColorHex.wrappedValue))
        self.title = title
    }
    
    public var body: some View {
        ColorPicker(
            title,
            selection: $selectedUnderlyingColor,
            supportsOpacity: true
        )
        .onChange(of: selectedUnderlyingColor) {
            selectedColorHex = $0.toHex()
        }
    }
}

// MARK: - Previews

struct HexColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        HexColorPicker(selectedColorHex: .constant("FFFFFF"), title: "Color")
    }
}
