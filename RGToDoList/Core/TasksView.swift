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
                //todoListsSelectionView
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
    
    @ViewBuilder
    var scrollViewTopAnchorView: some View {
        if viewModel.shouldShowNewEntryView {
            Color.clear.frame(height: 1)
                .id(viewModel.scrollViewAnchor)
        }
    }
}

#Preview {
    TasksView()
}
