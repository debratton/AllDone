//
//  AddTodoView.swift
//  AllDone
//
//  Created by David E Bratton on 8/6/22.
//

import SwiftUI

struct AddTodoView: View {
    // MARK: - PROPERTIES
    @Environment(\.dismiss) var closeView
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject private var todoVM = TodoViewModel()
    @State private var title = ""
    @State private var description = ""
    @State private var descriptionPlaceholder = "Enter description..."
    @State private var placeholderIsHidden = false
    @State private var selectedType: Categories = .All
    @State private var completed = false
    @State private var isshowingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @FocusState private var isFocused: Bool
    let user: AppUser
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    //colorScheme == .dark ? Color.white : Color.black
                    Color.blue
                    HStack {
                        Button {
                            closeView()
                        } label: {
                            Image(systemName: "x.circle")
                        } //END:BUTTON
                        Spacer()
                        Text("Add Task")
                        Spacer()
                        Button {
                            if title.isEmpty {
                                alertTitle = "Missing Information"
                                alertMessage = "You must enter a task before saving!"
                                isshowingAlert.toggle()
                            } else {
                                let newTodo = Todo(ownerId: user.uid, title: title, description: description, todoType: selectedType.rawValue, completed: completed)
                                todoVM.addTodo(todo: newTodo) { result, error in
                                    if !result {
                                        alertTitle = "Error Adding Todo"
                                        alertMessage = "\(error)"
                                        isshowingAlert.toggle()
                                    } else {
                                        closeView()
                                    }
                                }
                            }
                        } label: {
                            Image(systemName: "plus.circle")
                        } //END:BUTTON
                    } //END:HSTACK
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .font(.title)
                    .padding(.horizontal)
                } //END:ZSTACK
                .frame(height: 70)
                //Text(selectedType.rawValue)
                Form {
                    TextField("Task title...", text: $title)
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
                Spacer()
            } //END:VSTACK
            .navigationBarHidden(true)
        } //END:NAVVIEW
        .alert(isPresented: $isshowingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

// MARK: - PREVIEW
struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddTodoView(user: MockData.appUser01)
        }
    }
}
