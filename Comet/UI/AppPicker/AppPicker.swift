//
//  AppPicker.swift
//  Comet
//
//  Created by Noah Little on 9/4/2023.
//

import SwiftUI

// MARK: - Public

/// A view that allows you to select one or multiple applications from a list of applications.
public struct AppPicker: View {
    @StateObject private var viewModel: ViewModel
    @Binding var selectedAppIdentifier: String
    @Binding var selectedAppIdentifiers: [String]
    
    /// Allows you to select one app from a list of applications
    public init(
        selectedAppIdentifier: Binding<String>,
        title: String,
        visibleApplicationGroup: VisibleApplicationGroup = .all
    ) {
        self._selectedAppIdentifiers = .constant([])
        self._selectedAppIdentifier = selectedAppIdentifier
        self._viewModel = .init(
            wrappedValue: .init(
                visibleApplicationGroup: visibleApplicationGroup,
                title: title,
                isSinglePicker: true
            )
        )
    }
    
    /// Allows you to select multiple apps from a list of applications
    public init(
        selectedAppIdentifiers: Binding<[String]>,
        title: String,
        visibleApplicationGroup: VisibleApplicationGroup = .all
    ) {
        self._selectedAppIdentifier = .constant("")
        self._selectedAppIdentifiers = selectedAppIdentifiers
        self._viewModel = .init(
            wrappedValue: .init(
                visibleApplicationGroup: visibleApplicationGroup,
                title: title,
                isSinglePicker: false
            )
        )
    }
    
    public var body: some View {
        content
            .onAppear {
                viewModel.loadIfNeeded()
            }
    }
}

// MARK: - Private

private extension AppPicker {
    @ViewBuilder
    var content: some View {
        if viewModel.isSinglePicker {
            NavigationLink {
                AppPickerSingleListView(
                    apps: viewModel.appModels.filtered(visibleGroup: viewModel.visibleApplicationGroup),
                    sectionTitle: viewModel.visibleApplicationGroup.title,
                    selectedAppIdentifier: $selectedAppIdentifier
                )
                .navigationTitle(viewModel.title)
            } label: {
                labelView
            }
        } else {
            NavigationLink {
                AppPickerMultiListView(
                    apps: viewModel.appModels.filtered(visibleGroup: viewModel.visibleApplicationGroup),
                    sectionTitle: viewModel.visibleApplicationGroup.title,
                    selectedAppIdentifiers: $selectedAppIdentifiers
                )
                .navigationTitle(viewModel.title)
            } label: {
                labelView
            }
        }
    }
    
    var labelView: some View {
        HStack {
            Text(viewModel.title)
            Spacer()
            if viewModel.appModels.isEmpty {
                ProgressView()
            } else {
                selectedAppPreviewView()
            }
        }
        .padding(.vertical, 12.0)
    }
    
    @ViewBuilder
    func selectedAppPreviewView() -> some View {
        if viewModel.isSinglePicker {
            if let app = viewModel.app(matchingIdentifier: selectedAppIdentifier) {
                Image(uiImage: app.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(
                        width: 25,
                        height: 25
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 7.0))
            }
        } else {
            Text("\(selectedAppIdentifiers.count) \(selectedAppIdentifiers.count == 1 ? Copy.app : Copy.apps)")
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Previews

struct AppPicker_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            AppPicker(
                selectedAppIdentifier: .constant("com.apple.mobilemail"),
                title: "Select an app"
            )
        }
    }
}
