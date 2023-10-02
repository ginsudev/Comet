//
//  Preferences.swift
//  Comet
//
//  Created by Noah Little on 11/3/2023.
//

import Foundation

public struct Preferences {
    /// Sets any Codable-conforming type as the value of a given key.
    /// - Parameters:
    ///   - value: The new value to set.
    ///   - key: The key which the new value will be saved to.
    ///   - registry: The path to the .plist
    public static func setValue<T: Codable>(
        _ value: T,
        key: String,
        registry: String
    ) throws {
        let plistURL = URL(fileURLWithPath: registry)
        do {
            var dict = plistURL.plistDict()
            dict[key] = value
            let dictData = try PropertyListSerialization.data(
                fromPropertyList: dict,
                format: .xml,
                options: 0
            )
            try dictData.write(to: plistURL)
        } catch {
            throw error
        }
    }
    
    /// Retrieves a value from a given key within a .plist
    /// - Parameters:
    ///   - key: The key to retrieve the value for.
    ///   - registry: The path to the .plist.
    ///   - returnType: The `Type` that will be returned.
    /// - Returns: A value casted to the `returnType`.
    public static func value<T: Codable>(
        key: String,
        registry: String,
        returnType: T.Type
    ) -> T? {
        let plistURL = URL(fileURLWithPath: registry)
        let dict = plistURL.plistDict()
        return dict[key] as? T
    }
}

private extension URL {
    func plistDict() -> [String: Any] {
        var propertyListFormat: PropertyListSerialization.PropertyListFormat = .xml
        do {
            let data = try Data(contentsOf: self)
            guard let plistDict = try PropertyListSerialization.propertyList(
                from: data,
                options: .mutableContainersAndLeaves,
                format: &propertyListFormat
            ) as? [String : Any] else { return [:] } // Return empty dictionary if plist doesn't exist yet.
            return plistDict
        } catch {
            return [:]
        }
    }
}
