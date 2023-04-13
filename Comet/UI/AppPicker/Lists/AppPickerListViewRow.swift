//
//  AppPickerListViewRow.swift
//  Comet
//
//  Created by Noah Little on 10/4/2023.
//

import SwiftUI

struct AppPickerListViewRow: View {
    let app: AppPicker.AppModel
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 20.0) {
            Image(uiImage: app.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
            VStack(alignment: .leading) {
                Text(app.displayName)
                    .foregroundColor(.primary)
                    .font(.body)
                Text(app.id)
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
            Spacer()
            checkmarkView(isSelected: isSelected)
        }
    }
    
    @ViewBuilder
    func checkmarkView(isSelected: Bool) -> some View {
        if isSelected {
            Image(systemName: "checkmark.circle.fill")
        } else {
            Image(systemName: "circle")
        }
    }
}

struct AppPickerListViewRow_Previews: PreviewProvider {
    static var previews: some View {
        AppPickerListViewRow(
            app: .init(
                id: "123",
                displayName: "abc",
                isSystem: true,
                icon: nil
            ),
            isSelected: true
        )
    }
}
