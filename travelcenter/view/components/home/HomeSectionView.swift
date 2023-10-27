//
//  HomeSectionView.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 18/10/23.
//

import SwiftUI

struct HomeSectionView: View {
    
    let section: SectionModel
    
    private let sectionItemsHeight: CGFloat = 200
    
    var body: some View {
        VStack {
            Text(section.name)
                .fontWeight(.bold)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                ).padding(
                    EdgeInsets(
                        top: 0,
                        leading: mediumSpace,
                        bottom: 0,
                        trailing: mediumSpace
                    )
                )
            ScrollView(
                .horizontal,
                showsIndicators: false
            ) {
                LazyHStack {
                    ForEach(section.destinations, id: \.self.id) { destination in
                        HomeDestinationView(destination: destination)
                            .padding(
                                EdgeInsets(
                                    top: 0,
                                    leading: isFirstItem(destination) ? mediumSpace : smallSpace,
                                    bottom: 0,
                                    trailing: isLastItem(destination) ? mediumSpace : 0
                                )
                            )
                    }
                }.frame(height: sectionItemsHeight)
            }
        }
    }
    
    private func isFirstItem(_ destination: DestinationModel) -> Bool {
        return section.destinations.first == destination
    }
    
    private func isLastItem(_ destination: DestinationModel) -> Bool {
        return section.destinations.last == destination
    }
}

#Preview {
    HomeSectionView(
        section: SectionModel(
            name: "Destinos melhores avaliados",
            destinations: [
                DestinationModel(id: "1", name: "Paris", photo: "photoUrl", rate: "5.0"),
                DestinationModel(id: "2", name: "Tokyo", photo: "photoUrl", rate: "4.9"),
                DestinationModel(id: "3", name: "Roma", photo: "photoUrl", rate: "4.8"),
                DestinationModel(id: "4", name: "Miami", photo: "photoUrl", rate: "4.5")
            ]
        )
    )
}
