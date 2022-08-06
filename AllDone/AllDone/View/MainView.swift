//
//  MainView.swift
//  AllDone
//
//  Created by David E Bratton on 8/5/22.
//

import SwiftUI

struct MainView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.colorScheme) var colorScheme
    let user: AppUser
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                Text("MAIN VIEW")
            } //END:VSTACK
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        authVM.signout()
                    } label: {
                        HStack {
                            Image(systemName: "xmark.circle")
                            Text(user.email)
                        } //END:HSTACK
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .font(.caption)
                    } //END:BUTTON
                } //END:TOOLBARITEM
            } //END:TOOLBAR
        } //END:NAVVIEW
    }
}

// MARK: - PROPERTIES
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(user: MockData.appUser01)
    }
}
