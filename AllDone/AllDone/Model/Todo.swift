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
    let ownerId: String
    var title: String
    var description: String
    var todoType: String
    var completed: Bool
    //var documentID: String? = ""
    
    func getType() -> Categories {
        switch todoType {
        case "All":
            return .All
        case "Home":
            return .Home
        case "Work":
            return .Work
        case "Other":
            return .Other
        default:
            return .All
        }
    }
}
