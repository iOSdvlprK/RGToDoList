//
//  AlertDisplayable.swift
//  RGToDoList
//
//  Created by joe on 5/16/26.
//

import Foundation

@MainActor
protocol AlertDisplayable: AnyObject {
    var alert: AppAlert? { get set }
}
