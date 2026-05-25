//
//  AppUser.swift
//  RGToDoList
//
//  Created by joe on 5/25/26.
//

import Foundation
import FirebaseFirestore

struct AppUser {
    let userId: String
    let firstName: String
    let lastName: String
    let email: String
    let dateCreated: Timestamp?
    
    init(userId: String, firstName: String, lastName: String, email: String, dateCreated: Timestamp?) {
        self.userId = userId
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.dateCreated = dateCreated
    }
}

extension AppUser {
    static var empty: Self {
        .init(userId: .empty, firstName: .empty, lastName: .empty, email: .empty, dateCreated: nil)
    }
    
    static var mock: Self {
        .init(userId: "mock_user_1", firstName: "Joe", lastName: "K.", email: "joe3524@gmail.com", dateCreated: .init())
    }
}

extension AppUser: Codable {
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case dateCreated = "date_created"
    }
}
