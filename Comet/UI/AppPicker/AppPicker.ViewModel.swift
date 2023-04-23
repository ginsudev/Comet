//
//  AppPicker.ViewModel.swift
//  Comet
//
//  Created by Noah Little on 9/4/2023.
//

import Foundation
import UIKit.UIImage
import Combine

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
        let proxy: ApplicationWorkspace.ApplicationProxy
        let icon: UIImage
        var id: String { proxy.id }
        
        init(
            proxy: ApplicationWorkspace.ApplicationProxy,
            icon: UIImage?
        ) {
            self.proxy = proxy
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
        private var bag = Set<AnyCancellable>()
        private let workspace: ApplicationWorkspaceInterface
        private(set) var visibleApplicationGroup: VisibleApplicationGroup
        private(set) var title: String
        private(set) var isSinglePicker: Bool
        
        @Published private var appProxies: [ApplicationWorkspace.ApplicationProxy] = [] {
            didSet {
                if appProxies != cachedApplications {
                    cachedApplications = appProxies
                }
            }
        }
        
        private var cachedApplications: [ApplicationWorkspace.ApplicationProxy]? {
            get {
                UserDefaults.standard.appProxies(forKey: Keys.appCache)
            }
            
            set {
                UserDefaults.standard.setAppProxies(newValue, forKey: Keys.appCache)
            }
        }
        
        var appModels: [AppModel] {
            appProxies
                .map {
                    .init(
                        proxy: $0,
                        icon: UIImage._applicationIconImage(
                            forBundleIdentifier: $0.id,
                            format: 0,
                            scale: UIScreen.main.scale
                        )
                    )
                }
        }
        
        init(
            visibleApplicationGroup: VisibleApplicationGroup,
            title: String,
            isSinglePicker: Bool,
            workspace: ApplicationWorkspaceInterface = ApplicationWorkspace()
        ) {
            self.visibleApplicationGroup = visibleApplicationGroup
            self.title = title
            self.isSinglePicker = isSinglePicker
            self.workspace = workspace
            subscribe()
        }
        
        func loadIfNeeded() {
            if appProxies.isEmpty, let cachedApplications {
                self.appProxies = cachedApplications
            }
        }
        
        func app(matchingIdentifier identifier: String) -> AppModel? {
            guard let app = appModels.first(where: { $0.id == identifier }) else { return nil }
            return app
        }
    }
}

// MARK: - Private

private extension AppPicker.ViewModel {
    func subscribe() {
        workspace.loadApplicationsPublisher()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] proxies in
                self?.appProxies = proxies
            }
            .store(in: &bag)
    }
}
