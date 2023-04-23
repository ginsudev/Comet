//
//  CMApplicationWorkspaceMock.swift
//  Comet
//
//  Created by Noah Little on 13/4/2023.
//

import Foundation
import Combine

final class ApplicationWorkspaceMock: ApplicationWorkspaceInterface {
    func loadApplicationsPublisher() -> Future<[ApplicationWorkspace.ApplicationProxy], Never> {
        Future { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.2) {
                promise(
                    .success(
                        [
                            .init(id: "mock_id_1", displayName: "Mock_1", isSystem: true),
                            .init(id: "mock_id_2", displayName: "Mock_2", isSystem: false),
                            .init(id: "mock_id_3", displayName: "Mock_3", isSystem: false),
                            .init(id: "mock_id_4", displayName: "Mock_4", isSystem: true),
                            .init(id: "mock_id_5", displayName: "Mock_5", isSystem: true)
                        ]
                    )
                )
            }
        }
    }
}
