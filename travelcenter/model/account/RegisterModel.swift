//
//  RegisterModel.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 21/10/23.
//

import Foundation

struct RegisterModel: Codable {
    let name: String
    let email: String
    let password: String
    let confirmPassword: String
}
