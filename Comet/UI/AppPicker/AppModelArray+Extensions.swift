//
//  AppModelArray+Extensions.swift
//  Comet
//
//  Created by Noah Little on 11/4/2023.
//

import Foundation

extension Array where Element == AppPicker.AppModel {
    func filtered(visibleGroup: AppPicker.VisibleApplicationGroup) -> Self {
        switch visibleGroup {
        case .user:
            return self.filter { !$0.isSystem }
        case .system:
            return self.filter(\.isSystem)
        case .all:
            return self
        }
    }
}
