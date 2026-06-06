//
//  View+LoadingRedacted.swift
//  RGToDoList
//
//  Created by joe on 6/6/26.
//

import SwiftUI

struct LoadingRedactedModifier: ViewModifier {
    let condition: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if condition {
                loadingRedactedView
            }
        }
    }
    
    private var loadingRedactedView: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 16) {
                ForEach([TodoTask].mocks) { task in
                    TaskCompactView(task: task, isCompleted: Bool.random()) { }
                }
            }
            .padding()
        }
        .infinityFrame()
        .background(Color.appTheme.viewBackground)
        .redacted(reason: .placeholder)
        .disabled(true)
    }
}

extension View {
    func loadingRedacted(when condition: Bool) -> some View {
        modifier(LoadingRedactedModifier(condition: condition))
    }
}
