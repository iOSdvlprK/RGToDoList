//
//  AuthData.swift
//  RGToDoList
//
//  Created by joe on 5/10/26.
//

import FirebaseAuth

struct AuthData {
    let uid: String
    let email: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
    }
    
    init(email: String) {
        self.uid = UUID().uuidString
        self.email = email
    }
}

extension AuthData {
    static var mock: Self {
        .init(email: "iOSdvlprK@gmail.com")
    }
}
