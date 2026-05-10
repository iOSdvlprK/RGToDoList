//
//  Container+Registration.swift
//  RGToDoList
//
//  Created by joe on 5/9/26.
//

import FactoryKit

extension Container {
    var appInfoStore: Factory<AppInfoStore> {
        self { MainActor.assumeIsolated { AppInfoStore() } }.singleton
    }
    var authStore: Factory<any AuthStoreProtocol> {
        self { MainActor.assumeIsolated { AuthStore() } }.singleton
    }
}
