//
//  View+hideKeyboardOnTap.swift
//  RGToDoList
//
//  Created by joe on 5/20/26.
//

import SwiftUI

extension View {
    func hideKeyboardOnTap() -> some View {
        self
            .onTapGesture {
                hideKeyboard()
            }
    }
}
