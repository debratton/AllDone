//
//  TodoDetails.swift
//  AllDone
//
//  Created by David E Bratton on 8/8/22.
//

import SwiftUI

struct TodoDetails: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var closeView
    @ObservedObject private var todoVM = TodoViewModel()
    @State private var title = ""
    @State private var selectedType: Categories = .All
    @State private var completed = false
    @State private var description = ""
    @State private var descriptionPlaceholder = "Enter description..."
    @State private var placeholderIsHidden = false
    @FocusState private var isFocused: Bool
    @State private var isShowingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var appearCount = 0
    let todo: Todo
    let user: AppUser
    
    func loadValues() {
        if appearCount <= 1 {
            title = todo.title
            completed = todo.completed
            description = todo.description
            switch todo.todoType {
            case "All":
                selectedType = .All
            case "Groceries":
                selectedType = .Groceries
            case "Home":
                selectedType = .Home
            case "Work":
                selectedType = .Work
            case "School":
                selectedType = .School
            case "Personal":
                selectedType = .Personal
            case "Other":
                selectedType = .Other
            default:
                selectedType = .All
            }
        }
    }
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Form {
                TextField(title, text: $title)
                    .textFieldStyle(.roundedBorder)
                Picker("Types", selection: $selectedType) {
                    ForEach(Categories.allCases, id: \.id) { item in
                        Text(item.rawValue)
                    } //END:FOREACH
                } //END:PICKER
                Toggle(isOn: $completed) {
                    Text("Completed?")
                }
                ZStack(alignment: .leading) {
                    TextEditor(text: $description)
                        .focused($isFocused)
                        .onChange(of: isFocused) { isFocused in
                            if isFocused {
                                placeholderIsHidden = true
                            } else {
                                if description.isEmpty {
                                    placeholderIsHidden = false
                                } else {
                                    placeholderIsHidden = true
                                }
                            }
                        }
                        .onChange(of: description) { descriptionValue in
                            if descriptionValue.isEmpty {
                                placeholderIsHidden = false
                            } else {
                                placeholderIsHidden = true
                            }
                        }
                        
                    if description.isEmpty {
                        Text(descriptionPlaceholder)
                            .foregroundColor(.gray)
                            .opacity(placeholderIsHidden ? 0 : 1)
                            .onTapGesture {
                                placeholderIsHidden = true
                                isFocused = true
                            }
                    }
                } //END:ZSTACK
            } //END:FORM
        } //END:VSTACK
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if title.isEmpty {
                        alertTitle = "Missing Information"
                        alertMessage = "You must enter a task before saving!"
                        isShowingAlert.toggle()
                    } else {
                        let todo = Todo(id: todo.id, ownerId: user.uid, title: title, description: description, todoType: selectedType.rawValue, completed: completed)
                        todoVM.updateTodoAll(todo: todo) { result, error in
                            if !result {
                                alertTitle = "Update Failure"
                                alertMessage = "\(error)"
                                isShowingAlert.toggle()
                            } else {
                                closeView()
                            }
                        }
                    }
                } label: {
                    Image(systemName: "plus.circle")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .font(.title)
                } //END:BUTTON
            } //END:TOOLBARITEM
        } //END:TOOLBAR
        .navigationTitle("Todo Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            appearCount += 1
            loadValues()
        }
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

// MARK: - PREVIEW
struct TodoDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TodoDetails(todo: MockData.todo01, user: MockData.appUser01)
        }
    }
}
