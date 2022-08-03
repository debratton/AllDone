//
//  LoginView.swift
//  AllDone
//
//  Created by David E Bratton on 8/3/22.
//

import SwiftUI

struct LoginView: View {
    // MARK: - PROPERTIES
    @State private var email = ""
    @State private var password = ""
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            BackgroundGradientView(color1: .blue, color2: .blue)
            VStack {
                LogoView(width: 150, height: 150, imageName: "LoginLogo", title: "AllDone")
                    .padding()
                VStack(spacing: 20) {
                    EmailTextField(text: $email)
                        .padding(.horizontal)
                } //END:VSTACK
            } //END:VSTACK
        } //END:ZSTACK
    }
}

// MARK: - PREVIEW
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
