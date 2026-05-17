//
//  View+TextField.swift
//  RGToDoList
//
//  Created by joe on 5/17/26.
//

import SwiftUI

extension View {
    func textField(sfSymbol: String, resetAction: (() -> ())? = nil) -> some View {
        HStack(spacing: 5) {
            Image(systemName: sfSymbol)
                .frame(width: 30)
            self
            if let resetAction {
                Image(systemName: "xmark.circle")
                    .foregroundStyle(Color.appTheme.destructive)
                    .button(.press) {
                        resetAction()
                    }
            }
        }
        .foregroundStyle(Color.appTheme.accent)
        .padding(12)
        .background(Color.appTheme.cellBackground)
        .cornerRadius(.textfield)
    }
}
