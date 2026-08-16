//
//  Published+Preferences.swift
//  Comet
//
//  Created by Noah Little on 12/3/2023.
//

import Foundation
import Combine

private var cancellableSet: Set<AnyCancellable> = []

public extension Published where Value: Codable {
    /// Notifies subscribers when changes occur in a .plist.
    /// - Parameters:
    ///   - defaultValue: The default / fallback value.
    ///   - key: The key where the value will be read to & written from.
    ///   - registry: The path to the .plist file containing preferences.
    init(
        wrappedValue defaultValue: Value,
        key: String,
        registry: String
    ) {
        if let value = Preferences.value(
            key: key,
            registry: registry,
            returnType: Value.self
        ) {
            self.init(initialValue: value)
        } else {
            self.init(initialValue: defaultValue)
        }
        
        projectedValue
            .sink { value in
                try? Preferences.setValue(
                    value,
                    key: key,
                    registry: registry
                )
            }
            .store(in: &cancellableSet)
    }
}
