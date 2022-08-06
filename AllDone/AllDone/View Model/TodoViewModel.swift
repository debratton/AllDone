//
//  TodoViewModel.swift
//  AllDone
//
//  Created by David E Bratton on 8/6/22.
//

import SwiftUI
import Firebase

class TodoViewModel: ObservableObject {
    @Published var todos = [Todo]()
    @Published var showCreateTodoView = false
    @Published var filterTodoSelected: SelectedButton = .all
    @Published var todosFiltered = [Todo]()
    
    init() {
        loadTodos()
    }
    
    func loadTodos() {
        guard let user = AuthViewModel.shared.currentUser else { return }
        let query = COLLECTION_USERS.document(user.id ?? "").collection("to-dos").order(by: "completed", descending: false)
        query.addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            self.todos = documents.compactMap({ try? $0.data(as: Todo.self)})
            
            for index in stride(from: 0, to: self.todos.count, by: 1) {
                self.todos[index].documentID = documents[index].documentID
            }
            self.todosFiltered = self.todos
            
            if self.filterTodoSelected != .all {
                self.todosFiltered = self.todos.filter({ todo in
                    return todo.todoType == self.filterTodoSelected.rawValue
                })
            } else {
                self.todosFiltered = self.todos
            }
        }
    }
    
    func addTodo(todo: Todo, completion: @escaping (Bool, String) -> Void) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        let data: [String: Any] = [
            "title": todo.title,
            "description": todo.description,
            "type": todo.todoType,
            "completed": todo.completed,
            "ownerUid": user.id ?? ""
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
