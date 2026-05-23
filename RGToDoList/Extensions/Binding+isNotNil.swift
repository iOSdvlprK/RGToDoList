//
//  Binding+isNotNil.swift
//  RGToDoList
//
//  Created by joe on 5/23/26.
//

import SwiftUI

extension Binding {
    func isNotNil<Wrapped>() -> Binding<Bool> where Value == Optional<Wrapped> {
        .init {
            wrappedValue != nil
        } set: {
            if !$0 { wrappedValue = nil }
        }
    }
}
