//
//  MapView.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 25/10/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    let attractions: [DestinationAttractionModel]
    
    private let mapHeight: CGFloat = 300
    
    var body: some View {
        Map() {
            ForEach(attractions, id: \.self.id) { attraction in
                let coordinate = CLLocationCoordinate2D(
                    latitude: attraction.latitude,
                    longitude: attraction.longitude
                )
                Marker(
                    attraction.name,
                    coordinate: coordinate
                )
            }
        }.mapStyle(.standard)
        .frame(
            width: maxWidthWithPadding,
            height: mapHeight
        ).cornerRadius(defaultCornerRadius)
    }
}

#Preview {
    MapView(attractions: [
        DestinationAttractionModel(
            id: "1",
            name: "Jardim Botânico",
            longitude: -49.24131869389535,
            latitude: -25.44208889140478
        ),
        DestinationAttractionModel(
            id: "2",
            name: "Torre Panorâmica",
            longitude: -49.29411335903373,
            latitude: -25.42434707980776
        ),
        DestinationAttractionModel(
            id: "3",
            name: "Parque Tanguá",
            longitude: -49.28277205366564,
            latitude: -25.377477004608547
        )
    ])
}
