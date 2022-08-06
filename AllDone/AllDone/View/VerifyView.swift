//
//  ContentView.swift
//  AllDone
//
//  Created by David E Bratton on 8/3/22.
//

import SwiftUI

struct VerifyView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var authVM: AuthViewModel
    
    // MARK: - BODY
    var body: some View {
        Group {
            if authVM.userSession == nil {
                LoginView()
            } else {
                if let user = authVM.currentUser {
                    MainView(user: user)
                }
            }
        } //END:GROUP
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyView()
    }
}
