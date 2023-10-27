//
//  AddDestinationRatingModel.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 25/10/23.
//

import Foundation

struct AddDestinationRatingModel: Codable {
    let userId: String
    let destinationId: String
    let ratingText: String
    let rate: Int
}
