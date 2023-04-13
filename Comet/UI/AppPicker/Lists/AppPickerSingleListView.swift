//
//  AppPickerSingleListView.swift
//  Comet
//
//  Created by Noah Little on 10/4/2023.
//

import SwiftUI

// MARK: - Public

struct AppPickerSingleListView: View {
    let apps: [AppPicker.AppModel]
    let sectionTitle: String
    @Binding var selectedAppIdentifier: String
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
                            isSelected: selectedAppIdentifier == app.id
                        )
                    }
                }
            } header: {
                Text(sectionTitle)
            }
        }
        .compatSearchable(text: $searchQuery)
        .loading(apps.isEmpty, title: Copy.loadingApplications)
    }
}

// MARK: - Private

private extension AppPickerSingleListView {
    var filteredApps: [AppPicker.AppModel] {
        if searchQuery.isEmpty {
            return apps
        } else {
            return apps
                .filter { $0.id.hasPrefix(searchQuery) || $0.displayName.hasPrefix(searchQuery) }
        }
    }
    
    func onDidTapApp(_ app: AppPicker.AppModel) {
        if selectedAppIdentifier == app.id {
            selectedAppIdentifier = ""
        } else {
            selectedAppIdentifier = app.id
        }
    }
}

// MARK: - Previews

struct AppPickerSingleListView_Previews: PreviewProvider {
    static var previews: some View {
        AppPickerSingleListView(
            apps: [
                .init(id: "abc", displayName: "123", isSystem: true, icon: nil),
                .init(id: "eefw", displayName: "wfesdfsd", isSystem: true, icon: nil),
                .init(id: "gefwsd", displayName: "asddsf", isSystem: true, icon: nil),
                .init(id: "wsvfs", displayName: "adsgs", isSystem: true, icon: nil),
            ],
            sectionTitle: "System",
            selectedAppIdentifier: .constant("eefw")
        )
    }
}
