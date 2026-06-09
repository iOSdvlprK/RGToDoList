//
//  InfoData.swift
//  RGToDoList
//
//  Created by joe on 6/9/26.
//

import Foundation

struct InfoData {
    let name: String
    let info: String
}

extension InfoData: Identifiable {
    var id: String {
        UUID().uuidString
    }
}

extension InfoData: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.name == rhs.name && lhs.info == rhs.info
    }
}
