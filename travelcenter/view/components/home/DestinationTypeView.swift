//
//  DestinationTypeView.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 18/10/23.
//

import SwiftUI

struct DestinationTypeView: View {
    
    let destinationType: DestinationTypeModel
    
    private let iconSize: CGFloat = 20
    private let viewHeigth: CGFloat = 40
    private let viewCornerRadius: CGFloat = 20
    private let viewStrokeWidth: CGFloat = 1
    
    var body: some View {
        HStack {
            AsyncImage(
                url: URL(string: destinationType.iconUrl),
                content: { image in
                   image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(
                            maxWidth: iconSize,
                            maxHeight: iconSize
                        )
               },
                placeholder: {
                    Image(systemName: "mappin.and.ellipse")
                }
            ).frame(
                width: iconSize,
                height: iconSize
            ).padding(
                EdgeInsets(
                    top: 0,
                    leading: mediumSpace,
                    bottom: 0,
                    trailing: 0
                )
            )
            Text(destinationType.name)
                .foregroundStyle(.accent)
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: 0,
                        bottom: 0,
                        trailing: mediumSpace
                    )
                )
        }
        .frame(height: viewHeigth)
        .overlay(
            RoundedRectangle(cornerRadius: viewCornerRadius)
                .stroke(
                    Color.accentColor,
                    lineWidth: viewStrokeWidth
                )
        )
    }
}

#Preview {
    DestinationTypeView(destinationType: 
        DestinationTypeModel(
            id: "1",
            name: "Floresta",
            iconUrl: "icon"
        )
    )
}
