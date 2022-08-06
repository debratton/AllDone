//
//  SignUpView.swift
//  AllDone
//
//  Created by David E Bratton on 8/3/22.
//

import SwiftUI

struct SignUpView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) var closeView
    @Environment(\.colorScheme) var colorScheme
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isShowingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            BackgroundGradientView(color1: .blue, color2: .blue)
            VStack {
                LogoView(width: 150, height: 150, imageName: "LoginLogo", title: "New User Registration")
                    .padding()
                VStack(spacing: 20) {
                    UserTextView(text: $firstName, placeholder: "First Name", imageName: "person")
                    UserTextView(text: $lastName, placeholder: "Last Name", imageName: "person")
                    UserTextView(text: $email, placeholder: "Email", imageName: "envelope")
                    PasswordTextView(text: $password, placeholder: "Password", imageName: "lock")
                    PasswordTextView(text: $confirmPassword, placeholder: "Confirm Password", imageName: "lock")
                } //END:VSTACK
                .padding(.horizontal)
                Button {
                    authVM.register(email: email, password: password, firstName: firstName, lastName: lastName) { result, error in
                        if !result {
                            alertTitle = "Sign Up Error"
                            alertMessage = "\(error)"
                            isShowingAlert.toggle()
                        }
                    }
                } label: {
                    Text("Sign Up")
                        .padding()
                        .frame(width: 200)
                        .background(Color.blue.opacity(15))
                        .foregroundColor(.white)
                        .cornerRadius(20)
                } //END:BUTTON
                .padding(.top)
                Spacer()
                Button {
                    closeView()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "circle.circle.fill")
                        Text("Already have an account?")
                    } //END:HSTACK
                    .foregroundColor(.blue)
                    .font(.callout)
                }
            } //END:VSTACK
        } //END:ZSTACK
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    closeView()
                } label: {
                    Image(systemName: "delete.left.fill")
                        .foregroundColor(.white)
                } //END:BUTTON
            } //END:TOOLBARITEM
        } //END:TOOLBAR
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

// MARK: - PREVIEW
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignUpView()
        }
    }
}
