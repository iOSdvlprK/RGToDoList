//
//  AuthType.swift
//  RGToDoList
//
//  Created by joe on 5/15/26.
//

import SwiftUI

enum AuthType {
    case signIn
    case signUp
}

extension AuthType: CustomStringConvertible {
    var description: String {
        switch self {
        case .signIn:
            "Sign In"
        case .signUp:
            "Sign Up"
        }
    }
}

extension AuthType {
    var image: ImageResource {
        switch self {
        case .signIn:
                .signIn
        case .signUp:
                .signUp
        }
    }
    
    var title: String {
        switch self {
        case .signIn:
            "Login"
        case .signUp:
            "Register"
        }
    }
    
    var subTitle: String {
        switch self {
        case .signIn:
            "Sign in to access your account"
        case .signUp:
            "Create an account to get started"
        }
    }
    
    var authSwitchMessage: String {
        switch self {
        case .signIn:
            "Don't have an account?"
        case .signUp:
            "Already have an account?"
        }
    }
    
    var oppositeTypeDescription: String {
        switch self {
        case .signIn:
            AuthType.signUp.description
        case .signUp:
            AuthType.signIn.description
        }
    }
}

extension AuthType {
    var isSignIn: Bool {
        self == .signIn
    }
    
    var isSignUp: Bool {
        self == .signUp
    }
}
