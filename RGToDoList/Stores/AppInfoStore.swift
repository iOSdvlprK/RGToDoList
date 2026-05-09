//
//  AppInfoStore.swift
//  RGToDoList
//
//  Created by joe on 5/9/26.
//

import Foundation

final class AppInfoStore {
    let name: String = "RGToDoList"
    let description: String = "RGToDoList is a must app for anyone who wants to get their life organized. It helps you manage your tasks."
    let developer: String = "Joe K."
    var version: String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return version
        }
        return "-"
    }
    var compatibillity: String {
        if let minVersion = Bundle.main.infoDictionary?["MinimumOSVersion"] as? String {
            return "iOS \(minVersion)+"
        }
        return "-"
    }
}
