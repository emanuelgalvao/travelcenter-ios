//
//  CustomButton.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 19/10/23.
//

import SwiftUI

enum ButtonStyle {
    case normal
    case negative
    
    var color: Color {
        switch(self) {
        case .normal:
            Color.accent
        case .negative:
            Color(CustomColor.negativeColor ?? .red)
        }
    }
}

struct CustomButton: View {
    
    let title: String
    var style: ButtonStyle = .normal
    let action: () -> Void
    
    var body: some View {
        Text(title)
            .frame(width: maxWidthWithPadding)
            .padding(smallSpace)
            .background(style.color)
            .foregroundColor(.white)
            .cornerRadius(defaultCornerRadius)
            .onTapGesture {
                action()
            }
    }
}

#Preview {
    CustomButton(title: "Nome do botão") {
        
    }
}
