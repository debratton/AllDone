//
//  LoginView.swift
//  AllDone
//
//  Created by David E Bratton on 8/3/22.
//

import SwiftUI

struct LoginView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.colorScheme) var colorScheme
    @State private var email = ""
    @State private var password = ""
    @State private var isShowingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundGradientView(color1: .blue, color2: .blue)
                VStack {
                    LogoView(width: 150, height: 150, imageName: "LoginLogo", title: "Login")
                        .padding()
                    VStack(spacing: 20) {
                        EmailTextView(text: $email, placeholder: "Email", imageName: "envelope")
                        PasswordTextView(text: $password, placeholder: "Password", imageName: "lock")
                    } //END:VSTACK
                    .padding(.horizontal)
                    HStack {
                        Spacer()
                        NavigationLink {
                            ForgetPasswordView()
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "circle.circle.fill")
                                Text("Forgot Password?")
                            } //END:HSTACK
                            .foregroundColor(.white)
                            .font(.callout)
                        } //END:NAVLINK
                    } //END:HSTACK
                    .padding([.top, .trailing])
                    Button {
                        authVM.login(email: email, password: password) { result, error in
                            if !result {
                                alertTitle = "Login Error"
                                alertMessage = "\(error)"
                                isShowingAlert.toggle()
                            }
                        }
                    } label: {
                        Text("Login")
                            .padding()
                            .frame(width: 200)
                            .background(Color.blue.opacity(15))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    } //END:BUTTON
                    .padding(.top)
                    Spacer()
                    NavigationLink {
                        SignUpView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "circle.circle.fill")
                            Text("Don't have an account?")
                        } //END:HSTACK
                        .foregroundColor(.blue)
                        .font(.callout)
                    } //END:NAVLINK
                } //END:VSTACK
            } // END:ZSTACK
            .navigationBarHidden(true)
        } //END:NAVVIEW
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

// MARK: - PREVIEW
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
