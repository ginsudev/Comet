//
//  ApplicationWorkspace.swift
//  Comet
//
//  Created by Noah Little on 23/4/2023.
//

import Foundation
import Combine

internal protocol ApplicationWorkspaceInterface {
    func loadApplicationsPublisher() -> Future<[Comet.ApplicationWorkspace.ApplicationProxy], Never>
}

// MARK: - Internal

internal final class ApplicationWorkspace: ObservableObject, ApplicationWorkspaceInterface {
    struct ApplicationProxy: Codable, Equatable, Identifiable {
        let id: String
        let displayName: String
        let isSystem: Bool
    }
        
    func loadApplicationsPublisher() -> Future<[ApplicationProxy], Never> {
        return Future { [weak self] promise in
            self?.loadApplications { applications in
                promise(.success(applications))
            }
        }
    }
}

// MARK: - Private

private extension ApplicationWorkspace {
    func loadApplications(completion: @escaping ([ApplicationProxy]) -> Void) {
        DispatchQueue.global(qos: .background).async {
            guard let proxies = LSApplicationWorkspace.default().allApplications() else {
                completion([])
                return
            }
                        
            let mappedProxies = proxies
                .visibleProxies
                .compactMap {
                    ApplicationProxy(
                        id: $0.applicationIdentifier,
                        displayName: $0.localizedName,
                        isSystem: $0.applicationType == "isSystem"
                    )
                }
            completion(mappedProxies)
        }
    }
}

private extension Array where Element == LSApplicationProxy {
    var visibleProxies: Self {
        filter {
            guard !$0.applicationIdentifier.lowercased().contains("com.apple.webapp"),
                  !$0.correspondingApplicationRecord.appTags.contains(where: { $0 == "hidden" }),
                  !$0.correspondingApplicationRecord.isLaunchProhibited
            else { return false }
            return true
        }
    }
}
