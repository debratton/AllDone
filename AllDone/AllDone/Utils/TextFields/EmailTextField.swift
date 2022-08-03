//
//  EmailTextField.swift
//  AllDone
//
//  Created by David E Bratton on 8/3/22.
//

import SwiftUI

struct EmailTextField: View {
    // MARK: - PROPERTIES
    @Binding var text: String
    
    // MARK: - BODY
    var body: some View {
        CustomTextField(text: $text, placeholder: Text("Email"), imageName: "envelope")
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
            BackgroundGradientView()
            EmailTextField(text: .constant("Email"))
        }
    }
}
