//
//  Error+AsAppError.swift
//  RGToDoList
//
//  Created by joe on 5/22/26.
//

import FirebaseAuth
import FirebaseFirestore

extension Error? {
    func asAppError() -> AppError {
        guard let error = self else {
            return AuthError.empty
        }
        
        if let appError = error as? AppError {
            return appError
        }
        
        let nsError = error as NSError
        if nsError.domain == AuthErrorDomain {
            return AuthError.fromFirebaseError(nsError)
        } else if nsError.domain == FirestoreErrorDomain {
            return DatabaseError.fromFirebaseError(nsError)
        }
        return AuthError.unknown(nsError)
    }
}
