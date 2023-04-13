//
//  CMApplicationWorkspaceMock.swift
//  Comet
//
//  Created by Noah Little on 13/4/2023.
//

import Foundation

final class CMApplicationWorkspaceMock: CMApplicationWorkspaceInterface {
    func allApplications() -> [[AnyHashable : Any]]! {
        [
            [
                "identifier": "mock_id_1",
                "displayName": "Mock_1",
                "isSystem": 1
            ],
            [
                "identifier": "mock_id_2",
                "displayName": "Mock_2",
                "isSystem": 0
            ],
            [
                "identifier": "mock_id_3",
                "displayName": "Mock_3",
                "isSystem": 0
            ],
            [
                "identifier": "mock_id_4",
                "displayName": "Mock_4",
                "isSystem": 1
            ],
            [
                "identifier": "mock_id_5",
                "displayName": "Mock_5",
                "isSystem": 1
            ]
        ]
    }
    
    func icon(forBundleIdentifier bundleIdentifier: String!) -> UIImage! {
        .init(systemName: "checkmark")
    }
}
