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
        ScrollViewReader { scrollViewProxy in
            VStack(spacing: 12) {
                searchBarView
                todoListsSelectionView
                ScrollView {
                    VStack(spacing: 0) {
                        scrollViewTopAnchorView
                        //newTodoListView
                        //newTodoView
                    }
                    //tasksView
                        //.padding(.bottom)
                }
                .onChange(of: viewModel.shouldScrollToTop) { _, shouldScrollToTop in
                    if shouldScrollToTop { viewModel.scrollToTop(scrollViewProxy) }
                }
            }
        }
        .padding(.top)
    }
}

private extension TasksView {
    var searchBarView: some View {
        TextField("Search Tasks", text: $viewModel.searchText)
            .textField(
                sfSymbol: "magnifyingglass",
                resetAction: viewModel.shouldShowResetSearch ? { viewModel.resetSearch() } : nil
            )
            .padding(.horizontal)
            .animation(.spring, value: viewModel.shouldShowResetSearch)
    }
    
    var todoListsSelectionView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(viewModel.todoLists) { todoList in
                    TodoListNameView(
                        name: todoList.name,
                        isSelected: viewModel.isTodoListSelected(todoListId: todoList.id)
                    )
                    .button(.press) {
                        viewModel.selectTodoList(todoListId: todoList.id)
                    }
                    .contextMenu {
                        deleteTodoListButton(todoList: todoList)
                    }
                    .animation(.spring, value: viewModel.selectedTodoListId)
                }
                
                addNewTodoListButton
            }
            .padding(.horizontal)
            .padding(.vertical, 4)
        }
    }
    
    @ViewBuilder
    var scrollViewTopAnchorView: some View {
        if viewModel.shouldShowNewEntryView {
            Color.clear.frame(height: 1)
                .id(viewModel.scrollViewAnchor)
        }
    }
    
    func deleteTodoListButton(todoList: TodoList) -> some View {
        Label("Delete Todo List", systemImage: "trash")
            .button {
                Task(handlingError: viewModel) {
                    try await viewModel.deleteTodoList(todoList: todoList)
                }
            }
    }
    
    var addNewTodoListButton: some View {
        Image(systemName: "plus.circle.fill")
            .font(.title2)
            .foregroundStyle(Color.appTheme.alternateAccent)
            .button(.press) {
                viewModel.toggleNewTodoListView()
            }
    }
}

#Preview {
    TasksView()
        .injectMockData()
}
