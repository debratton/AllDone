//
//  BackgroundGradientView.swift
//  AllDone
//
//  Created by David E Bratton on 8/3/22.
//

import SwiftUI

struct BackgroundGradientView: View {
    // MARK: - PROPERTIES
    var color1: Color?
    var color2: Color?
    var color3: Color?
    
    // MARK: - BODY
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [color1 ?? .blue, color2?.opacity(0.5) ?? .white, color3?.opacity(0.1) ?? .white]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

// MARK: - PREVIEW
struct BackgroundGradientView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundGradientView(color1: .blue, color2: .blue, color3: .blue)
    }
}
