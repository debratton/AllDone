//
//  BackgroundGradientView.swift
//  AllDone
//
//  Created by David E Bratton on 8/3/22.
//

import SwiftUI

struct BackgroundGradientView: View {
    // MARK: - PROPERTIES
    
    // MARK: - BODY
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.blue, .blue.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

// MARK: - PREVIEW
struct BackgroundGradientView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundGradientView()
    }
}
