//
//  HomeDestinationView.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 18/10/23.
//

import SwiftUI

struct HomeDestinationView: View {
    
    let destination: DestinationModel
    
    @State private var showDestinationDetails: Bool = false
    
    private let destinationImageSize: CGFloat = 150
    private let destinationNameHeight: CGFloat = 50
    private let destinationRateWidth: CGFloat = 40
    private let destinationRateHeight: CGFloat = 30
    private let destinationCardHeight: CGFloat = 200
    
    var body: some View {
        VStack {
            AsyncImage(
                url: URL(string: destination.photo),
                content: { image in
                   image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(
                            maxWidth: destinationImageSize,
                            maxHeight: destinationImageSize
                        ).cornerRadius(defaultCornerRadius)
               },
               placeholder: {
                   ProgressView()
                       .frame(height: destinationImageSize)
               }
            )
            Spacer()
            HStack {
                Text(destination.name)
                    .fontWeight(.bold)
                Spacer()
                Text(destination.rate)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(
                        width: destinationRateWidth,
                        height: destinationRateHeight
                    ).background(.tabViewBackground)
                    .cornerRadius(defaultCornerRadius)
            }.padding(
                EdgeInsets(
                    top: 0,
                    leading: smallSpace,
                    bottom: 0,
                    trailing: smallSpace
                )
            ).frame(height: destinationNameHeight)
        }
        .frame(
            width: destinationImageSize,
            height: destinationCardHeight
        ).background(.white)
        .cornerRadius(defaultCornerRadius)
        .onTapGesture {
            showDestinationDetails = true
        }
        .sheet(isPresented: $showDestinationDetails, content: {
            DestinationDetailsView(destinationId: destination.id)
        })
    }
}

#Preview {
    HomeDestinationView(
        destination: DestinationModel(
            id: "1",
            name: "Nome do destino",
            photo: "photo",
            rate: "4.9"
        )
    )
}
