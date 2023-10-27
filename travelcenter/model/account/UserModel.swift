//
//  UserModel.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 21/10/23.
//

import Foundation

struct UserModel: CodableModel {
    let id: String
    let name: String
    let email: String
    let token: String
}
