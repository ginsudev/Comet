//
//  Bundle+Comet.swift
//  Comet
//
//  Created by Noah Little on 12/4/2023.
//

import Foundation
import libroot

internal extension Bundle {
    static var comet: Bundle {
        Bundle(path: jbRootPath("/Library/Frameworks/Comet.framework/Bundle.bundle/"))!
    }
}
