//
//  TodoViewModel.swift
//  AllDone
//
//  Created by David E Bratton on 8/6/22.
//

import SwiftUI
import Firebase
//import FirebaseFirestoreSwift

class TodoViewModel: ObservableObject {
    @Published var todos = [Todo]()
    @Published var showCreateTodoView = false
    @Published var filterTodoSelected: Categories = .All
    @Published var todosFiltered = [Todo]()
    
    init() {
        //loadTodos()
    }
    
    func loadTodos() {
        guard let user = AuthViewModel.shared.currentUser else { return }
        COLLECTION_USERS.document(user.uid)
            .collection("to-dos")
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("DEBUG: NO DOCS")
                    return
                }
                self.todos = documents.compactMap({ docSnapshot -> Todo? in
                    return try? docSnapshot.data(as: Todo.self)
                })
            }
        print("DEBUG: TODO COUNT: \(todos.count)")
    }
    
    func searchTodos(searchText: String) {
        //self.todos = self.todos.filter({ $0.title .contains(searchText)})
        self.todos = self.todos.filter({ $0.title .localizedCaseInsensitiveContains(searchText)})
    }
    
    func addTodo(todo: Todo, completion: @escaping (Bool, String) -> Void) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        let data: [String: Any] = [
            TODO_TITLE: todo.title,
            TODO_DESCRIPTION: todo.description,
            TODO_TYPE: todo.todoType,
            TODO_COMPLETED: todo.completed,
            TODO_OWNER: user.id ?? ""
        ]
        COLLECTION_USERS.document(user.id ?? "").collection("to-dos").addDocument(data: data) { error in
            if let error = error {
                print("ERROR ADDING TODO: \(error.localizedDescription)")
                completion(false, "\(error.localizedDescription)")
            } else {
                completion(true, "")
                self.loadTodos()
            }
        }
    }
    
    func deleteTodo(todoId: String, completion: @escaping (Bool, String) -> Void) {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        COLLECTION_USERS.document(uid).collection("to-dos").document(todoId).delete() { error in
            if let error = error {
                print("ERROR DELETING TODO: \(error.localizedDescription)")
                completion(false, "\(error.localizedDescription)")
            } else {
                completion(true, "")
                self.loadTodos()
            }
        }
    }
    
    func updateTodo(todoId: String, complete: Bool, completion: @escaping (Bool, String) -> Void) {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        COLLECTION_USERS.document(uid).collection("to-dos").document(todoId)
            .updateData(["completed" : complete]) { error in
                if let error = error {
                    print("ERROR UPDATING TODO = \(complete): \(error.localizedDescription)")
                    completion(false, "\(error.localizedDescription)")
                } else {
                    completion(true, "")
                    self.loadTodos()
                }
            }
    }
    
    func completeTodo(todoId: String, completion: @escaping (Bool, String) -> Void) {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        COLLECTION_USERS.document(uid).collection("to-dos").document(todoId)
            .updateData(["completed" : true]) { error in
                if let error = error {
                    print("ERROR COMPLETING TODO: \(error.localizedDescription)")
                    completion(false, "\(error.localizedDescription)")
                } else {
                    completion(true, "")
                    self.loadTodos()
                }
            }
    }
    
    func unCompleteTodo(todoId: String, completion: @escaping (Bool, String) -> Void) {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        COLLECTION_USERS.document(uid).collection("to-dos").document(todoId)
            .updateData(["completed" : false]) { error in
                if let error = error {
                    print("ERROR COMPLETING TODO: \(error.localizedDescription)")
                    completion(false, "\(error.localizedDescription)")
                } else {
                    completion(true, "")
                    self.loadTodos()
                }
            }
    }
}
