//
//  DestinationTypesView.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 18/10/23.
//

import SwiftUI

struct DestinationTypesView: View {
    
    let destinationTypes: [DestinationTypeModel]
    
    private let viewHeight: CGFloat = 40
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(destinationTypes, id: \.self.id) { destinationType in
                    DestinationTypeView(destinationType: destinationType)
                        .padding(
                            EdgeInsets(
                                top: 0,
                                leading: isFirstItem(destinationType) ? mediumSpace : smallSpace,
                                bottom: 0,
                                trailing: isLastItem(destinationType) ? mediumSpace : 0
                            )
                        )
                }
            }.frame(height: viewHeight)
        }
    }
    
    private func isFirstItem(_ destinationType: DestinationTypeModel) -> Bool {
        return destinationTypes.first == destinationType
    }
    
    private func isLastItem(_ destinationType: DestinationTypeModel) -> Bool {
        return destinationTypes.last == destinationType
    }
}

#Preview {
    DestinationTypesView(destinationTypes: [
        DestinationTypeModel(id: "1", name: "Floresta", iconUrl: "icon"),
        DestinationTypeModel(id: "2", name: "Cidade", iconUrl: "icon"),
        DestinationTypeModel(id: "3", name: "Europa", iconUrl: "icon"),
        DestinationTypeModel(id: "4", name: "Oriental", iconUrl: "icon")
    ])
}
