//
//  HomeDataModel.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 16/10/23.
//

import Foundation

struct HomeDataModel: CodableModel {
    let tip: String
    let destinationTypes: [DestinationTypeModel]
    let sections: [SectionModel]
}
