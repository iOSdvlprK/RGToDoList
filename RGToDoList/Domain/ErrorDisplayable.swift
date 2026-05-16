//
//  ErrorDisplayable.swift
//  RGToDoList
//
//  Created by joe on 5/16/26.
//

import Foundation

@MainActor
protocol ErrorDisplayable: AnyObject {
    var error: Error? { get set }
}
