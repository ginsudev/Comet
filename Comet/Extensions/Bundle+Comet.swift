//
//  Bundle+Comet.swift
//  Comet
//
//  Created by Noah Little on 12/4/2023.
//

import Foundation

extension Bundle {
    static var comet: Bundle {
        #if ROOTLESS
        let path = "/var/jb/Library/Frameworks/Comet.framework/Resources.bundle/"
        #else
        let path = "/Library/Frameworks/Comet.framework/Resources.bundle/"
        #endif
        
        if let bundle = Bundle(path: path) {
            NSLog("[Comet]: Bundle (\(path)): loaded")
            return bundle
        } else {
            NSLog("[Comet]: Bundle (\(path)): not loaded")
            return .main
        }
    }
}
