//
//  ForgetPasswordView.swift
//  AllDone
//
//  Created by David E Bratton on 8/4/22.
//

import SwiftUI

struct ForgetPasswordView: View {
    // MARK: - PROPERTIES
    @Environment(\.dismiss) var closeView
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Text("Forget Password")
        } //END:VSTACK
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    closeView()
                } label: {
                    Image(systemName: "delete.left.fill")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                } //END:BUTTON
            } //END:TOOLBARITEM
        } //END:TOOLBAR
    }
}

// MARK: - PREVIEW
struct ForgetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPasswordView()
            .preferredColorScheme(.dark)
    }
}
