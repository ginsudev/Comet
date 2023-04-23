//
//  UserDefaults+AppPicker.swift
//  Comet
//
//  Created by Noah Little on 23/4/2023.
//

import Foundation

extension UserDefaults {
    func setAppProxies(_ appProxies: [ApplicationWorkspace.ApplicationProxy]?, forKey key: String) {
        do {
            let data = try JSONEncoder().encode(appProxies)
            setValue(data, forKey: key)
        } catch {
            NSLog("[Comet]: \(error)")
        }
    }
    
    func appProxies(forKey key: String) -> [ApplicationWorkspace.ApplicationProxy]? {
        guard let data = value(forKey: key) as? Data else { return nil }
        do {
            let proxies = try JSONDecoder().decode([ApplicationWorkspace.ApplicationProxy].self, from: data)
            return proxies
        } catch {
            NSLog("[Comet]: \(error)")
            return nil
        }
    }
}
