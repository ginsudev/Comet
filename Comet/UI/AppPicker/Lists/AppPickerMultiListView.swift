//
//  AppPickerMultiListView.swift
//  Comet
//
//  Created by Noah Little on 10/4/2023.
//

import SwiftUI

// MARK: - Public

struct AppPickerMultiListView: View {
    let apps: [AppPicker.AppModel]
    let sectionTitle: String
    @Binding var selectedAppIdentifiers: [String]
    @State private var searchQuery = ""
    
    var body: some View {
        List {
            Section {
                ForEach(filteredApps) { app in
                    Button {
                        onDidTapApp(app)
                    } label: {
                        AppPickerListViewRow(
                            app: app,
                            isSelected: selectedAppIdentifiers.contains(app.id)
                        )
                    }
                }
            } header: {
                Text(sectionTitle)
            }
        }
        .compatSearchable(text: $searchQuery)
        .loading(apps.isEmpty, title: Copy.loadingApplications)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                trailingNavigationBarButton
            }
        }
    }
}

// MARK: - Private

private extension AppPickerMultiListView {
    @ViewBuilder
    var trailingNavigationBarButton: some View {
        if selectedAppIdentifiers.isEmpty {
            Button(Copy.selectAll) {
                selectedAppIdentifiers = apps.map(\.id)
            }
        } else {
            Button(Copy.unselectAll) {
                selectedAppIdentifiers = []
            }
        }
    }
    
    var filteredApps: [AppPicker.AppModel] {
        if searchQuery.isEmpty {
            return apps
        } else {
            return apps
                .filter {  $0.id.hasPrefix(searchQuery) || $0.displayName.hasPrefix(searchQuery) }
        }
    }
    
    func onDidTapApp(_ app: AppPicker.AppModel) {
        if selectedAppIdentifiers.contains(app.id) {
            selectedAppIdentifiers = selectedAppIdentifiers.filter { $0 != app.id }
        } else {
            selectedAppIdentifiers.append(app.id)
        }
    }
}

// MARK: - Previews

struct AppPickerMultiListView_Previews: PreviewProvider {
    static var previews: some View {
        AppPickerMultiListView(
            apps: [
                .init(id: "abc", displayName: "123", isSystem: true, icon: nil),
                .init(id: "eefw", displayName: "wfesdfsd", isSystem: true, icon: nil),
                .init(id: "gefwsd", displayName: "asddsf", isSystem: true, icon: nil),
                .init(id: "wsvfs", displayName: "adsgs", isSystem: true, icon: nil),
            ],
            sectionTitle: "System",
            selectedAppIdentifiers: .constant(
                [
                    "abc",
                    "eefw"
                ]
            )
        )
    }
}
