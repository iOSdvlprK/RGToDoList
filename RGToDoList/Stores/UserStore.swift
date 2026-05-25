//
//  UserStore.swift
//  RGToDoList
//
//  Created by joe on 5/25/26.
//

import Foundation
import FirebaseFirestore

@MainActor
final class UserStore: UserStoreProtocol {
    private let usersCollection = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        usersCollection.document(userId)
    }
    
    func createNewUser(user: AppUser) throws {
        try userDocument(userId: user.userId).setData(from: user)
    }
    
    func getUser(userId: String) async throws -> AppUser {
        try await userDocument(userId: userId).getDocument(as: AppUser.self)
    }
}
