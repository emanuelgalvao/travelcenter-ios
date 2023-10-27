//
//  ViewEvent.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 20/10/23.
//

import Foundation

enum ViewEvent<T> {
    case Error(message: String?)
    case Reender(data: T)
    case Loading
}
