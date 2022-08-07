//
//  SelectedButton.swift
//  AllDone
//
//  Created by David E Bratton on 8/5/22.
//

import SwiftUI

enum Categories: String, CaseIterable, Identifiable {
    case All, Groceries, Home, Work, School, Personal, Other
    var id: Self { self }
    
    func getValue() -> String {
        return self.rawValue
    }
}
