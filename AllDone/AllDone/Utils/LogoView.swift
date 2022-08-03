//
//  LogoView.swift
//  AllDone
//
//  Created by David E Bratton on 8/3/22.
//

import SwiftUI

struct LogoView: View {
    // MARK: - PROPERTIES
    var width: CGFloat
    var height: CGFloat
    var imageName: String
    var title: String
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: width, height: height)
            Text(title)
                .foregroundColor(.white)
                .font(.system(size: 25))
                .fontWeight(.semibold)
        } //END:VSTACK
    }
}

// MARK: - PREVIEW
struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundGradientView()
            LogoView(width: 150, height: 150, imageName: "LoginLogo", title: "AllDone")
        } //END:ZSTACK
    }
}
