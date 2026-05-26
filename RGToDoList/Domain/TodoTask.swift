//
//  TodoTask.swift
//  RGToDoList
//
//  Created by joe on 5/26/26.
//

import Foundation

struct TodoTask: Identifiable {
    let id: String
    let name: String
    let dateCreated: Date
    let description: String?
    
    init(id: String, name: String, description: String? = nil) {
        self.id = id
        self.name = name
        self.dateCreated = .init()
        self.description = description
    }
}

extension TodoTask: Equatable { }

extension TodoTask: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension TodoTask: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case dateCreated = "date_created"
        case description
    }
}

extension [TodoTask] {
    func filtered(by searchText: String) -> [TodoTask] {
        let lowercasedSearch = searchText.lowercased()
        return self.filter {
            searchText.isEmpty ||
            $0.name.lowercased().contains(lowercasedSearch) ||
            ($0.description?.lowercased().contains(lowercasedSearch) ?? false)
        }
    }
}

extension [TodoTask] {
    func partitionedByCompletion(using completedTaskIds: Set<String>) -> (incomplete: [TodoTask], complete: [TodoTask]) {
        let incomplete = self.filter { !completedTaskIds.contains($0.id) }
        let complete = self.filter { completedTaskIds.contains($0.id) }
        return (incomplete, complete)
    }
}

extension [TodoTask] {
    func sortedByDate() -> [TodoTask] {
        self.sorted { $0.dateCreated < $1.dateCreated }
    }
}

extension TodoTask {
    static var mock: Self {
        [Self].mocks[0]
    }
}

extension [TodoTask] {
    static var mocks: Self {
        [
            .init(id: "mock_task_1", name: "Get groceries", description: "Go to Walmart and Target"),
            .init(id: "mock_task_2", name: "Call Mom", description: nil),
            .init(id: "mock_task_3", name: "Go for a walk", description: nil),
            .init(id: "mock_task_4",
                  name: "Replace leaky faucet in the guest bathroom. Follow steps.",
                  description:
"""
While investigating the mysterious puddle in the bathroom, I discovered the faucet has taken on a hobby—impersonating a miniature water park. To-do steps:
1) Shut off the water supply so we don’t need a rowboat to reach the kitchen.
2) Retrieve a brand-new faucet from the hardware store.
3) Swap out the old faucet. If it still sprays like Old Faithful, consult the nearest plumber.

Final goal: Zero aquatic surprises for future guests (and happier socks for all).
"""
                 ),
        ]
    }
}
