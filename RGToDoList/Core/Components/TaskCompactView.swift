//
//  TaskCompactView.swift
//  RGToDoList
//
//  Created by joe on 6/1/26.
//

import SwiftUI

struct TaskCompactView: View {
    let task: TodoTask
    let isCompleted: Bool
    let onToggle: () -> ()
    
    var body: some View {
        HStack(spacing: 8) {
            toggleButtonView
            VStack(spacing: 6) {
                nameView
                descriptionView
            }
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(Color.appTheme.cellBackground)
        .cornerRadius(.cell)
        .shadow(.light)
    }
}

private extension TaskCompactView {
    var toggleButtonView: some View {
        Image(systemName: isCompleted ? "checkmark.square.fill" : "square")
            .font(.title)
            .foregroundStyle(Color.appTheme.accent)
            .button(.press) {
                onToggle()
            }
    }
    
    var nameView: some View {
        Text(task.name)
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    var descriptionView: some View {
        if let description = task.description {
            HStack(alignment: .firstTextBaseline, spacing: 5) {
                Image(systemName: "text.justify")
                Text(description)
                    .multilineTextAlignment(.leading)
            }
            .font(.footnote)
            .foregroundStyle(Color.appTheme.secondaryText)
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

fileprivate struct Preview: View {
    @State private var tasks: [TodoTask] = .mocks
    @State private var completedTasks: Set<TodoTask> = .init()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 16) {
                ForEach(tasks) { task in
                    TaskCompactView(task: task, isCompleted: isCompleted(task)) {
                        toggleCompletion(task)
                    }
                }
            }
            .padding()
        }
        .infinityFrame()
        .background(Color.appTheme.viewBackground)
    }
    
    func toggleCompletion(_ task: TodoTask) {
        withAnimation(.spring) {
            if completedTasks.contains(task) {
                completedTasks.remove(task)
            } else {
                completedTasks.insert(task)
            }
        }
    }
    
    func isCompleted(_ task: TodoTask) -> Bool {
        completedTasks.contains(task)
    }
}

#Preview {
    Preview()
}
