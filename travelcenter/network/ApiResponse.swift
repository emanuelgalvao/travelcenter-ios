//
//  ApiResponse.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 16/10/23.
//

import Foundation

enum ApiResponse {
    case Error(message: String)
    case Success(data: Any)
}
