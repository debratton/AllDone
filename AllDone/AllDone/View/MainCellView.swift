//
//  MainCellView.swift
//  AllDone
//
//  Created by David E Bratton on 8/7/22.
//

import SwiftUI

struct MainCellView: View {
    // MARK: - PROPERTIES
    @ObservedObject private var todoVM = TodoViewModel()
    @State private var isCompleted = false
    @State private var isShowingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    let todo: Todo
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue)
            VStack(alignment: .leading) {
                Text(todo.title)
                    .bold()
                HStack {
                    Text("Type:")
                    Text(todo.todoType)
                    Spacer()
                } //END:HSTACK
                .font(.caption)
                .foregroundColor(.secondary)
                Toggle(isOn: $isCompleted) {
                    Text("Complete?")
                }.onChange(of: isCompleted) { newValue in
                    todoVM.updateTodo(todoId: todo.id ?? "", complete: newValue) { result, error in
                        if !result {
                            alertTitle = "Update Failed"
                            alertMessage = "\(error)"
                            isShowingAlert.toggle()
                        } else {
                            todoVM.loadTodos()
                        }
                    }
                }
            } //END:VSTACK
            .padding()
            .onAppear {
                isCompleted = todo.completed
            }
        } //END:ZSTACK
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

// MARK: - PREVIEW
struct MainCellView_Previews: PreviewProvider {
    static var previews: some View {
        MainCellView(todo: MockData.todo01)
            .previewLayout(.sizeThatFits)
    }
}
