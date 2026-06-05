//
//  View+injectMockData.swift
//  RGToDoList
//
//  Created by joe on 6/5/26.
//

import SwiftUI
import FactoryKit

struct injectMockModifier: ViewModifier {
    private static var hasInjected = false
    
    init() {
        guard !Self.hasInjected else { return }
        Self.hasInjected = true
        injectMockData()
    }
    
    func body(content: Content) -> some View {
        content
    }
    
    private func injectMockData() {
        Container.shared.authStore.register {
            MainActor.assumeIsolated { MockAuthStore() }
        }
        Container.shared.userStore.register {
            MainActor.assumeIsolated { MockUserStore() }
        }
        Container.shared.todoStore.register {
            MainActor.assumeIsolated { MockTodoStore() }
        }
    }
}

extension View {
    func injectMockData() -> some View {
        self.modifier(injectMockModifier())
    }
}
