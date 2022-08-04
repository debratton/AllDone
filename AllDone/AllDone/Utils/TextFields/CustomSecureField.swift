//
//  CustomSecureField.swift
//  AllDone
//
//  Created by David E Bratton on 8/3/22.
//

import SwiftUI

struct CustomSecureField: View {
    // MARK: - PROPERTIES
    @Binding var text: String
    let placeholder: Text
    let imageName: String
    var foregroundColor: Color?
    
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .foregroundColor(Color(.init(white: 1, alpha: 0.8)))
                    .padding(.leading, 40)
            }
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(foregroundColor ?? .white)
                SecureField("", text: $text)
                    .autocapitalization(.none)
            } //END:HSTACK
        } //END:ZSTACK
    }
}

// MARK: - PREVIEW
struct CustomSecureField_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundGradientView()
            CustomSecureField(text: .constant(""), placeholder: Text("Password"), imageName: "lock")
        }
    }
}
