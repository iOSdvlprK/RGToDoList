//
//  ErrorView.swift
//  RGToDoList
//
//  Created by joe on 5/22/26.
//

import SwiftUI

struct ErrorView: View {
    @Binding var error: Error?
    
    private var appError: AppError {
        error.asAppError()
    }
    
    var body: some View {
        VStack(spacing: 16) {
            headingView
            messageView
            understandButtonView
        }
        .padding()
        .background(Color.appTheme.cellBackground)
        .cornerRadius(.cell)
        .frame(width: (UIScreen.current?.bounds.width ?? .zero) / 1.2)
    }
}

private extension ErrorView {
    var headingView: some View {
        HStack {
            Image(systemName: "exclamationmark.triangle.fill")
            Text(appError.title)
        }
        .font(.title3)
        .fontWeight(.semibold)
        .foregroundStyle(Color.appTheme.error)
    }
    
    var messageView: some View {
        Text(appError.message)
            .foregroundStyle(Color.appTheme.secondaryText)
            .multilineTextAlignment(.center)
    }
    
    var understandButtonView: some View {
        Text("Understand")
            .destructiveButton()
            .button(.press) {
                dismiss()
            }
    }
}

private extension ErrorView {
    func dismiss() {
        error = nil
    }
}

fileprivate struct Preview: View {
    @State private var error: Error? = AuthError.mock
    
    var body: some View {
        ErrorView(error: $error)
            .infinityFrame()
            .background(Color.appTheme.info)
    }
}

#Preview {
    Preview()
}
