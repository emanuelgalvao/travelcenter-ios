//
//  DestinationSimpleItemView.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 18/10/23.
//

import SwiftUI

struct DestinationSimpleItemView: View {
    
    let destination: DestinationSimpleModel
    var icon: String = "map"
    
    @State var showSheet: Bool = false
    
    private let viewHeight: CGFloat = 50
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: mediumSpace,
                        bottom: 0,
                        trailing: 0
                    )
                )
            Text(destination.destinationName)
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: smallSpace,
                        bottom: 0,
                        trailing: 0
                    )
                )
            Spacer()
            Image(systemName: "chevron.right")
                .frame(height: viewHeight)
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: mediumSpace,
                        bottom: 0,
                        trailing: mediumSpace
                    )
                )
        }
        .frame(
            width: maxWidthWithPadding,
            height: viewHeight,
            alignment: .leading
        )
        .background(.white)
        .cornerRadius(defaultCornerRadius)
        .onTapGesture {
            showSheet = true
        }
        .sheet(isPresented: $showSheet, content: {
            DestinationDetailsView(destinationId: destination.destinationId)
        })
    }
}

#Preview {
    DestinationSimpleItemView(
        destination: DestinationSimpleModel(
            id: "1",
            destinationId: "1",
            destinationName: "Paris"
        )
    )
}
