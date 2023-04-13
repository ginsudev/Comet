//
//  String+CometLocalized.swift
//  Comet
//
//  Created by Noah Little on 12/4/2023.
//

import Foundation

internal extension String {
    var localized: Self {
        String(NSLocalizedString(self, bundle: .comet, comment: ""))
    }
}
