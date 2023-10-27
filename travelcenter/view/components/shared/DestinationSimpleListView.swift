//
//  DestinationSimpleListView.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 20/10/23.
//

import SwiftUI

struct DestinationSimpleListView: View {
    
    let destinations: [DestinationSimpleModel]
    var icon: String = ""
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(destinations, id: \.self.id) { destination in
                    DestinationSimpleItemView(
                        destination: destination,
                        icon: icon
                    )
                }
            }
        }.padding(
            EdgeInsets(
                top: 0,
                leading: 0,
                bottom: 1,
                trailing: 0
            )
        )
    }
}

#Preview {
    DestinationSimpleListView(
        destinations: [
            DestinationSimpleModel(id: "1", destinationId: "1", destinationName: "Destino 1"),
            DestinationSimpleModel(id: "2", destinationId: "2", destinationName: "Destino 2"),
            DestinationSimpleModel(id: "3", destinationId: "3", destinationName: "Destino 3")
        ]
    )
}
