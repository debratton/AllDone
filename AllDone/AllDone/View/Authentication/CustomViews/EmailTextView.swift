//
//  EmailTextField.swift
//  AllDone
//
//  Created by David E Bratton on 8/3/22.
//

import SwiftUI

struct EmailTextView: View {
    // MARK: - PROPERTIES
    @Binding var text: String
    let placeholder: String
    let imageName: String
    
    // MARK: - BODY
    var body: some View {
        CustomTextField(text: $text, placeholder: Text("\(placeholder)"), imageName: imageName)
            .padding()
            .background(Color(.init(white: 1, alpha: 0.15)))
            .cornerRadius(10)
            .foregroundColor(.white)
    }
}

// MARK: - PREVIEW
struct EmailTextField_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundGradientView(color1: .blue, color2: .blue)
            EmailTextView(text: .constant(""), placeholder: "Email", imageName: "envelope")
        }
    }
}
