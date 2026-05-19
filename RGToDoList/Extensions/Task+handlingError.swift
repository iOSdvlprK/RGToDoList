//
//  Task+handlingError.swift
//  RGToDoList
//
//  Created by joe on 5/19/26.
//

extension Task where Success == Void, Failure == Error {
    @MainActor
    @discardableResult
    init(priority: TaskPriority? = nil, handlingError viewModel: ErrorDisplayable, operation: @escaping () async throws -> Success) {
        self.init(priority: priority) {
            do {
                try await operation()
            } catch {
                viewModel.error = error
            }
        }
    }
}
