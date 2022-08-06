//
//  ForgetPasswordView.swift
//  AllDone
//
//  Created by David E Bratton on 8/4/22.
//

import SwiftUI

struct ForgetPasswordView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) var closeView
    @Environment(\.colorScheme) var colorScheme
    @State private var email = ""
    @State private var isShowingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            BackgroundGradientView(color1: .blue, color2: .blue)
            VStack {
                LogoView(width: 150, height: 150, imageName: "LoginLogo", title: "Reset Password")
                    .padding()
                VStack(spacing: 20) {
                    UserTextView(text: $email, placeholder: "Email", imageName: "envelope")
                } //END:VSTACK
                .padding(.horizontal)
                Button {
                    authVM.resetPassword(email: email) { result, error in
                        if !result {
                            alertTitle = "Reset Password Error"
                            alertMessage = "\(error)"
                            isShowingAlert.toggle()
                        } else {
                            alertTitle = "Reset Password"
                            alertMessage = "You have successfully submitted a password reset.  Please check your email and follow the directios on resetting your password.  Once complete go to the login screen and authenticate with your new password."
                            isShowingAlert.toggle()
                            email = ""
                        }
                    }
                } label: {
                    Text("Send Password Reset")
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
                        Text("Back to login?")
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
struct ForgetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPasswordView()
            .preferredColorScheme(.dark)
    }
}
