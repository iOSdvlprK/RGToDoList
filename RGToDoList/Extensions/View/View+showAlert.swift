//
//  View+showAlert.swift
//  RGToDoList
//
//  Created by joe on 5/24/26.
//

import SwiftUI

extension View {
    func showAlert(item: Binding<AppAlert?>) -> some View {
        showModal(item: item) { alert in
            AlertView(alert: item)
                .transition(
                    .move(edge: .bottom)
                    .combined(with: .opacity)
                )
        }
    }
}

fileprivate struct PreviewView: View {
    @State private var alert: AppAlert?
    
    var body: some View {
        Text("Show Alert")
            .primaryButton()
            .button(.press) {
                alert = AppAlert.mock1
            }
            .padding()
            .infinityFrame()
            .background(Color.appTheme.viewBackground)
            .showAlert(item: $alert)
    }
}

#Preview {
    PreviewView()
        .preferredColorScheme(.light)
}

#Preview {
    PreviewView()
        .preferredColorScheme(.dark)
}
