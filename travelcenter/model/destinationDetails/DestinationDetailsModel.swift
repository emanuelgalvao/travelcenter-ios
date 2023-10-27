//
//  DestinationDetailsModel.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 21/10/23.
//

import Foundation

struct DestinationDetailsModel: CodableModel {
    let destinationInfo: DestinationInfoModel
    let destinationAttractions: [DestinationAttractionModel]
    let ratings: [DestinationRatingModel]
}
