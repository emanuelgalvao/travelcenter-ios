//
//  SuccessInsertView.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 25/10/23.
//

import SwiftUI

struct SuccessInsertView: View {
    
    let title: String
    let description: String
    let completion: () -> Void
    
    var body: some View {
        VStack {
            Image(systemName: "checkmark.circle")
                .scaleEffect(largeImageScale)
                .frame(
                    width: largeImageSize,
                    height: largeImageSize
                )
            Text(title)
                .font(.title2)
            Text(description)
                .font(.title2)
            CustomButton(title: "Continuar") {
                completion()
            }
        }
    }
}
