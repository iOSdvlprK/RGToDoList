//
//  TodoStoreProtocol.swift
//  RGToDoList
//
//  Created by joe on 5/26/26.
//

import Foundation
import Combine

@MainActor
protocol TodoStoreProtocol: ObservableObject {
    func getTodoLists(for userId: String) async throws -> [TodoList]
    func loadTasksIntoTodoLists(todoLists: [TodoList]) async -> [TodoList]
    
    func addTodoList(name: String, ownerId: String) throws
    func deleteTodoList(todoListId: String) async throws
    func addTask(todoListId: String, name: String, description: String?) async throws
    func deleteTask(todoListId: String, taskId: String) async throws
    
    func setupUser(userId: String) throws
    
    func todoListsPublisher(userId: String) -> AnyPublisher<[TodoList], Error>
    func taskPublishers(todoLists: [TodoList]) -> [String: AnyPublisher<[TodoTask], Error>]
    func removeAllListeners()
}
