//
//  TasksViewModel.swift
//  RGToDoList
//
//  Created by joe on 5/28/26.
//

import SwiftUI
import Combine
import FactoryKit

@MainActor
final class TasksViewModel: ObservableObject {
    @Published var searchText: String = .empty
    @Published var todoLists: [TodoList] = .init()
    @Published var selectedTodoList: TodoList?
    @Published var currentTasks: [TodoTask] = .init()
    @Published var currentCompletedTasks: [TodoTask] = .init()
    @Published var selectedTodoListId: String?
    @Published var isViewLoading: Bool = true
    @Published var shouldShowNewTodoView: Bool = false
    @Published var shouldShowNewTodoListView: Bool = false
    @Published var shouldScrollToTop: Bool = false
    @Published var shouldShowSettings: Bool = false
    @Published var completedTaskIds: Set<String> = .init()
    @Published var alert: AppAlert?
    @Published var error: Error?
    private var cancellables = Set<AnyCancellable>()
    @Injected(\.authStore) var authStore
    @Injected(\.todoStore) var todoStore
    @Injected(\.appInfoStore) var appInfoStore
    
    let scrollViewAnchor: UUID = .init()
    
    init() {
         loadData()
        // setSubscribers()
    }
    
    var shouldShowResetSearch: Bool {
        !searchText.isEmpty
    }
    
    var shouldShowEmptyStateForTasks: Bool {
        currentTasks.isEmpty && currentCompletedTasks.isEmpty && searchText.isEmpty
    }
    
    var shouldShowEmptySearchStateForTasks: Bool {
        currentTasks.isEmpty && currentCompletedTasks.isEmpty && !searchText.isEmpty
    }
    
    var shouldShowNewEntryView: Bool {
        shouldShowNewTodoView || shouldShowNewTodoListView
    }
}

private extension TasksViewModel {
    func loadData() {
        guard let userId = authStore.getAuthenticatedUser()?.uid else { return }
        Task(handlingError: self) {
            self.isViewLoading = true
            defer { self.isViewLoading = false }
            self.todoLists = try await self.todoStore.getTodoLists(for: userId)
            self.selectedTodoListId = self.todoLists.firstId()
        }
    }
}

extension TasksViewModel: ErrorDisplayable { }

extension TasksViewModel: AlertDisplayable { }
