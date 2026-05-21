//
//  AppError.swift
//  RGToDoList
//
//  Created by joe on 5/21/26.
//

import Foundation

protocol AppError: LocalizedError {
    var title: String { get }
    var message: String { get }
    static func fromFirebaseError(_ error: NSError) -> AppError
}
