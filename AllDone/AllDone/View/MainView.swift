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
    let user: AppUser
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack{
                List {
                    ForEach(todoVM.todos, id: \.id) { todo in
                        Text(todo.title)
                            .foregroundColor(.white)
                    } //END:FOREACH
                } //END:LIST
                .searchable(text: $searchText)
                .onChange(of: searchText) { newValue in
                    if newValue.isEmpty {
                        todoVM.loadTodos()
                    } else {
                        todoVM.searchTodos(searchText: newValue)
                    }
                }
            } //END:VSTACK
            .navigationTitle("Todo List")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        authVM.signout()
                    } label: {
                        HStack {
                            Image(systemName: "xmark.circle")
                            Text(user.email)
                        } //END:HSTACK
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .font(.caption)
                    } //END:BUTTON
                } //END:TOOLBARITEM
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("ADD CLICKED")
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
