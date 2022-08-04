//
//  PasswordTextField.swift
//  AllDone
//
//  Created by David E Bratton on 8/3/22.
//

import SwiftUI

struct PasswordTextView: View {
    // MARK: - PROPERTIES
    @Binding var text: String
    let placeholder: String
    let imageName: String
    
    // MARK: - BODY
    var body: some View {
        CustomSecureField(text: $text, placeholder: Text("\(placeholder)"), imageName: imageName)
            .padding()
            .background(Color(.init(white: 1, alpha: 0.15)))
            .cornerRadius(10)
            .foregroundColor(.white)
    }
}

// MARK: - PREVIEW
struct PasswordTextField_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundGradientView(color1: .blue, color2: .blue)
            PasswordTextView(text: .constant(""), placeholder: "Password", imageName: "lock")
        }
    }
}
