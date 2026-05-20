//
//  View+hideKeyboard.swift
//  RGToDoList
//
//  Created by joe on 5/20/26.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
