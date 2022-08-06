//
//  AuthViewModel.swift
//  AllDone
//
//  Created by David E Bratton on 8/5/22.
//

import SwiftUI
import Firebase
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var userSession: User?
    @Published var currentUser: AppUser?
    
    static let shared = AuthViewModel()
    
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            if let error = error {
                print("ERROR FETCHING USERS: \(error.localizedDescription)")
                return
            } else {
                guard let user = try? snapshot?.data(as: AppUser.self) else { return }
                self.currentUser = user
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Bool, String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("ERROR SIGNING IN: \(error.localizedDescription)")
                completion(false, "\(error.localizedDescription)")
            }
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
            completion(true, "")
        }
    }
    
    func register(email: String, password: String, firstName: String, lastName: String, completion: @escaping (Bool, String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("ERROR REGISTERING NEW USER: \(error.localizedDescription)")
                completion(false, "\(error.localizedDescription)")
            }
            guard let user = result?.user else { return }
            let data = [
                "uid": user.uid,
                "firstName": firstName,
                "lastName": lastName,
                "email": user.email ?? email
            ]
            COLLECTION_USERS.document(user.uid).setData(data) { error in
                if let error = error {
                    print("ERROR UPLOADING REGISTERED USER TO FIRESTORE USERS COLLECTION: \(error.localizedDescription)")
                    completion(false, "\(error.localizedDescription)")
                }
                print("SUCCESS UPLOADING REGISTERED USER TO FIRESTORE USERS COLLECTION")
                self.userSession = user
                self.fetchUser()
                completion(true, "")
            }
        }
    }
    
    func signout() {
        self.userSession = nil
        try? Auth.auth().signOut()
    }
    
    func resetPassword(email: String, completion: @escaping (Bool, String) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("ERROR SENDING PASSWORD RESET: \(error.localizedDescription)")
                completion(false, "\(error.localizedDescription)")
            } else {
                completion(true, "")
            }
        }
    }
}
