//
//  MockData.swift
//  AllDone
//
//  Created by David E Bratton on 8/5/22.
//

import Foundation

struct MockData {
    static let todos = [Todo]()
    
    static let appUser01 = AppUser(id: "1", uid: "1", firstName: "David", lastName: "Bratton", email: "debratton@gmail.com")

    static let todo01 = Todo(id: "1", ownerID: "1", title: "Wine", description: "Nice Merlot under $12.00", todoType: "Groceries", completed: false)
    static let todo02 = Todo(id: "2", ownerID: "2", title: "Cheese", description: "Get a nice mixture of cheeses", todoType: "Groceries", completed: false)
    static let todo03 = Todo(id: "3", ownerID: "3", title: "Mow Lawn", description: "Mow lawn weekly", todoType: "Home", completed: false)
}


