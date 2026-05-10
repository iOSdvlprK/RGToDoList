//
//  AuthStoreProtocol.swift
//  RGToDoList
//
//  Created by joe on 5/10/26.
//

import Foundation
import Combine

@MainActor
protocol AuthStoreProtocol: ObservableObject {
    var authUpdate: Date { get set }
    var authUpdatePublisher: AnyPublisher<Date, Never> { get }
    
    func getAuthenticatedUser() -> AuthData?
    
    @discardableResult
    func signIn(email: String, password: String) async throws -> AuthData
    
    @discardableResult
    func signUp(email: String, password: String) async throws -> AuthData
    
    func resetPassword(email: String) async throws
    func signOut() throws
}
