//
//  TasksView.swift
//  RGToDoList
//
//  Created by joe on 5/28/26.
//

import SwiftUI

struct TasksView: View {
    @StateObject var viewModel: TasksViewModel = .init()
    
    var body: some View {
        Text("Tasks Main View")
    }
}

#Preview {
    TasksView()
}
