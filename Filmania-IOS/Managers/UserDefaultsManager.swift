//
//  UserDefaultsManager.swift
//  Filmania-IOS
//
//  Created by Furkan Türkyaşar on 10.02.2025.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let walkthroughCompletedKey = "walkthroughCompleted"
    
    private init() {}
    
    func isWalkthroughCompleted() -> Bool {
        UserDefaults.standard.bool(forKey: walkthroughCompletedKey)
    }
}
