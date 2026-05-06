//
//  AppStartingView.swift
//  RGToDoList
//
//  Created by joe on 3/26/26.
//

import SwiftUI

struct AppStartingView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    AppStartingView()
}
