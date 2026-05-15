//
//  AuthViewModel.swift
//  RGToDoList
//
//  Created by joe on 5/15/26.
//

import SwiftUI
import Combine
import FactoryKit

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var currentAuthType: AuthType = .signIn
    @Published var firstName: String = .empty
    @Published var lastName: String = .empty
    @Published var email: String = .empty
    @Published var password: String = .empty
    @Published var forgotPasswordSuccess: Bool = false
    @Published var error: Error?
    @Published var alert: AppAlert?
    @Injected(\.authStore) var authStore
//    @Injected(\.userStore) var userStore
//    @Injected(\.todoStore) var todoStore
}
