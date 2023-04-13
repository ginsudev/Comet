//
//  AppPicker.ViewModel.swift
//  Comet
//
//  Created by Noah Little on 9/4/2023.
//

import Foundation

// MARK: - Public

public extension AppPicker {
    enum VisibleApplicationGroup {
        case user
        case system
        case all
        
        var title: String {
            switch self {
            case .user: return Copy.user
            case .system: return Copy.system
            case .all: return Copy.allApps
            }
        }
    }
}

// MARK: - Internal

internal extension AppPicker {
    struct AppModel: Identifiable, Equatable {
        let id: String
        let displayName: String
        let isSystem: Bool
        let icon: UIImage
        
        init(
            id: String,
            displayName: String,
            isSystem: Bool,
            icon: UIImage?
        ) {
            self.id = id
            self.displayName = displayName
            self.isSystem = isSystem
            
            if let icon {
                self.icon = icon
            } else {
                if #available(iOS 15, *) {
                    self.icon = UIImage(systemName: "questionmark.app.fill")!
                } else {
                    self.icon = UIImage(systemName: "questionmark.square.fill")!
                }
            }
        }
    }
    
    final class ViewModel: ObservableObject {
        private let workspace: CMApplicationWorkspaceInterface
        private(set) var visibleApplicationGroup: VisibleApplicationGroup
        private(set) var title: String
        private(set) var isSinglePicker: Bool
        
        private var cachedApplications: [[AnyHashable: Any]]? {
            get {
                UserDefaults.standard.value(forKey: Keys.appCache) as? [[AnyHashable: Any]]
            }
            
            set {
                UserDefaults.standard.setValue(newValue, forKey: Keys.appCache)
            }
        }

        @Published private(set) var apps: [AppModel] = []
        
        init(
            visibleApplicationGroup: VisibleApplicationGroup,
            title: String,
            isSinglePicker: Bool,
            workspace: CMApplicationWorkspaceInterface = CMApplicationWorkspace()
        ) {
            self.visibleApplicationGroup = visibleApplicationGroup
            self.title = title
            self.isSinglePicker = isSinglePicker
            self.workspace = workspace
        }
        
        func loadIfNeeded() {
            if apps.isEmpty {
                loadApplicationsFromCache()
            }
        }
        
        func app(matchingIdentifier identifier: String) -> AppModel? {
            guard let app = apps.first(where: { $0.id == identifier }) else { return nil }
            return app
        }
    }
}

// MARK: - Private

private extension AppPicker.ViewModel {
    func loadApplicationsFromCache() {
        DispatchQueue.global().async { [weak self] in
            guard let self else { return }
            
            // Load applications from cache if they exist.
            if let cachedApplications {
                let appModels = createAppModels(dictionaries: cachedApplications)
                set(apps: appModels) { [weak self] in
                    guard let self else { return }
                    loadApplications()
                }
            } else {
                loadApplications()
            }
        }
    }
    
    func loadApplications() {
        DispatchQueue.global().async { [weak self] in
            guard let self else { return }
            // Load updated applications
            if let allApplications = workspace.allApplications() {
                let appModels = createAppModels(dictionaries: allApplications)
                self.cachedApplications = allApplications
                set(apps: appModels)
            }
        }
    }
    
    func set(
        apps: [AppPicker.AppModel],
        completion: (() -> Void)? = nil
    ) {
        DispatchQueue.main.async { [weak self] in
            self?.apps = apps
            completion?()
        }
    }
    
    func createAppModels(dictionaries: [[AnyHashable: Any]]) -> [AppPicker.AppModel] {
        dictionaries
            .compactMap { [weak self] in
                guard let self,
                      let id = $0["identifier"] as? String,
                      let displayName = $0["displayName"] as? String,
                      let isSystem = $0["isSystem"] as? Int
                else { return nil }
                return AppPicker.AppModel(
                    id: id,
                    displayName: displayName,
                    isSystem: isSystem == 1,
                    icon: workspace.icon(forBundleIdentifier: id)
                )
            }
    }
}
