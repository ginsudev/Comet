//
//  String+CometLocalized.swift
//  Comet
//
//  Created by Noah Little on 12/4/2023.
//

import Foundation

extension String {
    internal var localized: Self {
        String(NSLocalizedString(self, bundle: .comet, comment: ""))
    }
}
