//
//  Respring.swift
//  Comet
//
//  Created by Noah Little on 23/4/2023.
//

import Foundation

public struct Respring {
    public static func execute() {
        let action = _SBSRelaunchAction(
            reason: "RestartRenderServer",
            options: .fadeToBlackTransition,
            targetURL: nil
        )
        
        _FBSSystemService.shared().send([action], withResult: nil)
    }
}
