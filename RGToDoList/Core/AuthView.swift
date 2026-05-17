//
//  AuthView.swift
//  RGToDoList
//
//  Created by joe on 5/15/26.
//

import SwiftUI

struct AuthView: View {
    @StateObject private var viewModel: AuthViewModel = .init()
    
    var body: some View {
        VStack(spacing: 20) {
            imageView
            headingView
            inputFieldsView
        }
        .padding()
        .infinityFrame()
        .background(Color.appTheme.viewBackground)
    }
}

private extension AuthView {
    var imageView: some View {
        Image(viewModel.currentAuthType.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: (UIScreen.current?.bounds.width ?? .zero) / 1.3)
    }
    
    var headingView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.currentAuthType.title)
                .font(.title)
            
            Text(viewModel.currentAuthType.subTitle)
        }
        .fontWeight(.semibold)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var inputFieldsView: some View {
        VStack(spacing: 12) {
            if viewModel.currentAuthType.isSignIn {
                TextField("First Name", text: $viewModel.firstName)
                    .textContentType(.givenName)
                    .textField(sfSymbol: "person")
                
                TextField("Last Name", text: $viewModel.lastName)
                    .textContentType(.familyName)
                    .textField(sfSymbol: "person")
            }
            
            TextField("Email", text: $viewModel.email)
                .textContentType(.emailAddress)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .textField(sfSymbol: "envelope")
            
            SecureField("Password", text: $viewModel.password)
                .textContentType(.password)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .textField(sfSymbol: "lock")
        }
    }
}

#Preview {
    AuthView()
}
