//
//  AppStartingView.swift
//  RGToDoList
//
//  Created by joe on 3/26/26.
//

import SwiftUI

struct AppStartingView: View {
    @StateObject private var viewModel: AppStartingViewModel = .init()
    
    var body: some View {
        Group {
            switch viewModel.appState {
            case .auth:
                AuthView()
            case .app:
                NavigationStack {
                    Text("App")
                }
            }
        }
        .animation(.spring, value: viewModel.appState)
    }
}

#Preview {
    AppStartingView()
}
