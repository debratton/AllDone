//
//  SelectedButton.swift
//  AllDone
//
//  Created by David E Bratton on 8/5/22.
//

import Foundation

enum SelectedButton: String {
    case all = "All"
    case groceries = "Groceries"
    case work = "Work"
    case school = "School"
    case home = "Home"
    case personal = "Personal"
    case other = "Other"
    
    func getValue() -> String {
        return self.rawValue
    }
}
