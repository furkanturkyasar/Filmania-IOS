//
//  BaseUtil.swift
//  Filmania-IOS
//
//  Created by Furkan Türkyaşar on 16.02.2025.
//


import Foundation

struct BaseUtil {
    static func randomString(length: Int) -> String {
        return UUID().uuidString.replacingOccurrences(of: "-", with: "").prefix(length).lowercased()
    }
}
