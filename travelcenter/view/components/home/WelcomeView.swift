//
//  WelcomeView.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 26/10/23.
//

import SwiftUI

struct WelcomeView: View {
    
    @Binding var showSheet: Bool
    
    private let sheetHeightFraction: CGFloat = 0.7
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .frame(
                    width: largeImageSize, 
                    height: largeImageSize
                )
                .padding(
                    EdgeInsets(
                        top: mediumSpace,
                        leading: 0,
                        bottom: 0,
                        trailing: 0
                    )
                )
            Text("Bem-vindo(a) ao TravelCenter!")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.accent)
                .padding(
                    EdgeInsets(
                        top: smallSpace,
                        leading: 0,
                        bottom: 0,
                        trailing: 0
                    )
                )
            Text("Aqui você encontrará dicas de destinos para sua próxima viagem.")
                .frame(maxWidth: maxWidthWithPadding)
                .multilineTextAlignment(.center)
                .font(.title3)
                .padding(
                    EdgeInsets(
                        top: smallSpace,
                        leading: 0,
                        bottom: 0,
                        trailing: 0
                    )
                )
            Text("É possível visualizar informações sobre os destinos e avaliações feitas por outros usuários.")
                .frame(maxWidth: maxWidthWithPadding)
                .multilineTextAlignment(.center)
                .font(.title3)
                .padding(
                    EdgeInsets(
                        top: smallSpace,
                        leading: 0,
                        bottom: 0,
                        trailing: 0
                    )
                )
            Text("Você também poderá favoritar destinos e adicionar avaliações.")
                .frame(maxWidth: maxWidthWithPadding)
                .multilineTextAlignment(.center)
                .font(.title3)
                .padding(
                    EdgeInsets(
                        top: smallSpace,
                        leading: 0,
                        bottom: 0,
                        trailing: 0
                    )
                )
            CustomButton(title: "Continuar") {
                WelcomeManager.shared.setShowedWelcomeMessage()
                showSheet = false
            }.padding(
                EdgeInsets(
                    top: smallSpace,
                    leading: 0,
                    bottom: mediumSpace,
                    trailing: 0
                )
            )
        }.presentationDetents([.fraction(sheetHeightFraction)])
    }
}
