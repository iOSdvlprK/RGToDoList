//
//  View+keyboardToolbarDoneButton.swift
//  RGToDoList
//
//  Created by joe on 5/20/26.
//

import SwiftUI

struct KeyboardToolbarDoneButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button {
                        content.hideKeyboard()
                    } label: {
                        Text("Done")
                            .foregroundStyle(Color.appTheme.accent)
                    }
                }
            }
    }
}

extension View {
    func keyboardToolbarDoneButton() -> some View {
        self.modifier(KeyboardToolbarDoneButtonModifier())
    }
}
