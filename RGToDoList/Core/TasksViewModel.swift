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
         setSubscribers()
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
    
    func setSubscribers() {
        guard let userId = authStore.getAuthenticatedUser()?.uid else { return }
        
        $searchText
            .combineLatest($selectedTodoList, $completedTaskIds)
            .sink { [weak self] searchText, selectedTodoList, completedTaskIds in
                guard let self else { return }
                (currentTasks, currentCompletedTasks) = (selectedTodoList?.tasks ?? [])
                    .filtered(by: searchText)
                    .sortedByDate()
                    .partitionedByCompletion(using: completedTaskIds)
            }
            .store(in: &cancellables)
        
        todoStore.todoListsPublisher(userId: userId)
            .sink {_ in } receiveValue: { [weak self] todoLists in
                guard let self else { return }
                Task(handlingError: self) {
                    self.todoLists = await self.todoStore.loadTasksIntoTodoLists(todoLists: todoLists)
                    self.subscribeToTasks(for: todoLists)
                }
            }
            .store(in: &cancellables)
        
        subscribeToTasks(for: todoLists)
        
        $selectedTodoListId
            .sink { [weak self] selectedTodoListId in
                guard let self else { return }
                updateCurrentTodoList(with: selectedTodoListId)
            }
            .store(in: &cancellables)
        
        $shouldShowNewTodoView
            .combineLatest($shouldShowNewTodoListView)
            .map { $0 || $1 }
            .assign(to: &$shouldScrollToTop)
    }
    
    func subscribeToTasks(for todoLists: [TodoList]) {
        let taskPublishers = self.todoStore.taskPublishers(todoLists: todoLists)
        taskPublishers.forEach { todoListId, publisher in
            publisher
                .sink { _ in } receiveValue: { [weak self] tasks in
                    guard let self else { return }
                    updateTasks(for: todoListId, with: tasks)
                }
                .store(in: &cancellables)
        }
    }
    
    func updateTasks(for todoListId: String, with tasks: [TodoTask]) {
        guard let index = todoLists.firstIndex(matchingId: todoListId) else { return }
        var updatedTodoLists = todoLists
        updatedTodoLists[index].tasks = tasks
        todoLists = updatedTodoLists
        if selectedTodoList?.id == todoListId {
            selectedTodoList = updatedTodoLists[index]
        }
    }
    
    func updateCurrentTodoList(with selectedTodoListId: String?) {
        selectedTodoList = todoLists.first(matchingId: selectedTodoListId)
    }
}

extension TasksViewModel: ErrorDisplayable { }

extension TasksViewModel: AlertDisplayable { }
