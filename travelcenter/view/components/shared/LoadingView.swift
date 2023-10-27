//
//  LoadingView.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 25/10/23.
//

import SwiftUI

struct LoadingView: View {
    
    private let loadingScale: CGFloat = 2
    private let loadingFontSize: CGFloat  = 8
    
    var body: some View {
        ProgressView("Carregando...")
            .scaleEffect(loadingScale)
            .font(.system(size: loadingFontSize))
    }
}

#Preview {
    LoadingView()
}
