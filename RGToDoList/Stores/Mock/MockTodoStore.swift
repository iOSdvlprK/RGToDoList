//
//  MockTodoStore.swift
//  RGToDoList
//
//  Created by joe on 5/27/26.
//

import Foundation
import FirebaseFirestore
import Combine

@MainActor
final class MockTodoStore: ObservableObject, TodoStoreProtocol {
    func getTodoLists(for userId: String) async throws -> [TodoList] {
        .mocks
    }
    
    func loadTasksIntoTodoLists(todoLists: [TodoList]) async -> [TodoList] {
        .mocks
    }
    
    func addTodoList(name: String, ownerId: String) throws { }
    
    func deleteTodoList(todoListId: String) async throws { }
    
    func addTask(todoListId: String, name: String, description: String? = nil) async throws { }
    
    func deleteTask(todoListId: String, taskId: String) async throws { }
    
    func setupUser(userId: String) throws { }
    
    func todoListsPublisher(userId: String) -> AnyPublisher<[TodoList], Error> {
        Just(.mocks)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func taskPublishers(todoLists: [TodoList]) -> [String: AnyPublisher<[TodoTask], Error>] {
        var mockPublishers: [String: AnyPublisher<[TodoTask], Error>] = [:]
        for list in todoLists {
            guard let listId = list.id else { continue }
            let publisher = Just([TodoTask].mocks)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
            
            mockPublishers[listId] = publisher
        }
        return mockPublishers
    }
    
    func removeAllListeners() { }
}
