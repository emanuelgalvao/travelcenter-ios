//
//  SectionModel.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 16/10/23.
//

import Foundation

struct SectionModel: Codable {
    let name: String
    let destinations: [DestinationModel]
}
