//
//  DatabaseError.swift
//  RGToDoList
//
//  Created by joe on 5/21/26.
//

import Foundation
import FirebaseFirestore

enum DatabaseError: LocalizedError {
    case missingFields
    case documentNotFound
    case permissionDenied
    case networkError
    case unknown(Error)
}

extension DatabaseError: AppError {
    var title: String {
        "Todo Error"
    }
    
    var message: String {
        return switch self {
        case .missingFields:
            "Some required fields are missing. Please complete all fields and try again."
        case .documentNotFound:
            "The requested todo item was not found."
        case .permissionDenied:
            "You do not have permission to perform this action."
        case .networkError:
            "A network error occurred while trying to access your todos. Check your connection and try again."
        case .unknown(let error):
            error.localizedDescription
        }
    }
}

extension DatabaseError {
    static func fromFirebaseError(_ error: NSError) -> AppError {
        let errorCode = FirestoreErrorCode.Code(rawValue: error.code)
        return switch errorCode {
        case .notFound:
            DatabaseError.documentNotFound
        case .permissionDenied:
            DatabaseError.permissionDenied
        case .unavailable, .deadlineExceeded:
            DatabaseError.networkError
        default:
            DatabaseError.unknown(error)
        }
    }
}
