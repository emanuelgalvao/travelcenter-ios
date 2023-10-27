//
//  ErrorView.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 20/10/23.
//

import SwiftUI

struct ErrorView: View {
    
    let action: () -> Void
    
    var body: some View {
        VStack {
            Text("Ocorreu um erro!")
            CustomButton(title: "Tentar novamente", action: action)

        }
    }
}

#Preview {
    ErrorView() {
        
    }
}
