//
//  DestinationRatingView.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 20/10/23.
//

import SwiftUI

struct DestinationRatingView: View {
    
    let rating: DestinationRatingModel
    
    var body: some View {
        VStack {
            Text(rating.description)
                .padding(
                    EdgeInsets(
                        top: mediumSpace,
                        leading: mediumSpace,
                        bottom: mediumSpace,
                        trailing: mediumSpace
                    )
                )
                .frame(
                    width: maxWidthWithPadding,
                    alignment: .leading
                )
            HStack {
                Text(rating.rating)
                Image(systemName: "star.fill")
                Spacer()
                Text("- \(rating.userName)")
            }.padding(
                EdgeInsets(
                    top: 0,
                    leading: mediumSpace,
                    bottom: mediumSpace,
                    trailing: mediumSpace
                )
            ).frame(
                width: maxWidthWithPadding,
                alignment: .trailing
            )
        }.frame(width: maxWidthWithPadding)
        .background(.white)
        .cornerRadius(defaultCornerRadius)
    }
}

#Preview {
    DestinationRatingView(
        rating: DestinationRatingModel(
            id: "1", 
            userName: "Emanuel",
            description: "Descrição",
            rating: "5.0"
        )
    )
}
