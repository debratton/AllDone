//
//  AllDoneApp.swift
//  AllDone
//
//  Created by David E Bratton on 8/3/22.
//

import SwiftUI
import Firebase

@main
struct AllDoneApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            VerifyView()
                .environmentObject(AuthViewModel.shared)
                .preferredColorScheme(.dark)
        }
    }
}
