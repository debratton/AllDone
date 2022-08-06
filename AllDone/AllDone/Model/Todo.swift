//
//  Todo.swift
//  AllDone
//
//  Created by David E Bratton on 8/5/22.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct Todo: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    let ownerID: String
    var title: String
    var description: String
    var todoType: String
    var completed: Bool
    var documentID: String? = ""
    
    func getType() -> SelectedButton {
        switch todoType {
        case "Groceries":
            return .groceries
        case "Work":
            return .work
        case "School":
            return .school
        case "Home":
            return .home
        case "Personal":
            return .personal
        default:
            return .other
        }
    }
    
}
