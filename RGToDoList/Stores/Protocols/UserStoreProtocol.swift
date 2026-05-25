//
//  UserStoreProtocol.swift
//  RGToDoList
//
//  Created by joe on 5/25/26.
//

import Foundation

protocol UserStoreProtocol {
    func createNewUser(user: AppUser) throws
    func getUser(userId: String) async throws -> AppUser
}
