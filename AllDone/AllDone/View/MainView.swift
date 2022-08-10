//
//  MainView.swift
//  AllDone
//
//  Created by David E Bratton on 8/5/22.
//

import SwiftUI

struct MainView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject private var todoVM = TodoViewModel()
    @State private var searchText = ""
    @State private var isShowingAddTodo = false
    @State private var isShowingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var selectedType: Categories = .All
    let user: AppUser
    
    func deleteTodo(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let todo = todoVM.todos[index]
            todoVM.deleteTodo(todoId: todo.id ?? "") { result, error in
                if !result {
                    alertTitle = "Error Deleting Todo"
                    alertMessage = "\(error)"
                    isShowingAlert.toggle()
                } else {
                    todoVM.loadTodos()
                }
            }
        }
    }
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                Menu("Filter List: \(selectedType.rawValue)") {
                    Button {
                        selectedType = .All
                        todoVM.loadTodos()
                    } label: {
                        Text("All")
                    }
                    Button {
                        selectedType = .Groceries
                        todoVM.loadTodosFiltered(type: .Groceries)
                    } label: {
                        Text("Groceries")
                    }
                    Button {
                        selectedType = .Home
                        todoVM.loadTodosFiltered(type: .Home)
                    } label: {
                        Text("Home")
                    }
                    Button {
                        selectedType = .Work
                        todoVM.loadTodosFiltered(type: .Work)
                    } label: {
                        Text("Work")
                    }
                    Button {
                        selectedType = .School
                        todoVM.loadTodosFiltered(type: .School)
                    } label: {
                        Text("School")
                    }
                    Button {
                        selectedType = .Personal
                        todoVM.loadTodosFiltered(type: .Personal)
                    } label: {
                        Text("Personal")
                    }
                    Button {
                        selectedType = .Other
                        todoVM.loadTodosFiltered(type: .Other)
                    } label: {
                        Text("Other")
                    }
                }
                List {
                    ForEach(todoVM.todos, id: \.id) { todo in
                        NavigationLink {
                            TodoDetails(todo: todo, user: user)
                        } label: {
                            MainCellView(todo: todo)
                        } //END:NAVLINK
                    } //END:FOREACH
                    .onDelete(perform: deleteTodo)
                } //END:LIST
                .listStyle(.plain)
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                .onChange(of: searchText) { newValue in
                    if newValue.isEmpty {
                        todoVM.loadTodos()
                    } else {
                        todoVM.searchTodos(searchText: newValue)
                    }
                }
            } //END:VSTACK
            .navigationTitle("Todo List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        authVM.signout()
                    } label: {
                        HStack {
                            Image(systemName: "xmark.circle")
                            Text(user.firstName)
                        } //END:HSTACK
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .font(.caption)
                    } //END:BUTTON
                } //END:TOOLBARITEM
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingAddTodo.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .font(.title)
                    } //END:BUTTON
                } //END:TOOLBARITEM
            } //END:TOOLBAR
        } //END:NAVVIEW
        .onAppear {
            todoVM.loadTodos()
        }
        .sheet(isPresented: $isShowingAddTodo) {
            todoVM.loadTodos()
        } content: {
            AddTodoView(user: user)
        }
    }
}

// MARK: - PROPERTIES
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(user: MockData.appUser01)
    }
}
