//
//  Constants.swift
//  AllDone
//
//  Created by David E Bratton on 8/4/22.
//

import Foundation
import Firebase

let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_TODOS = Firestore.firestore().collection("to-dos")

let TODO_OWNER = "ownerId"
let TODO_TITLE = "title"
let TODO_DESCRIPTION = "description"
let TODO_TYPE = "todoType"
let TODO_COMPLETED = "completed"
