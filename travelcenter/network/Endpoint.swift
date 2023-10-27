//
//  Endpoint.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 16/10/23.
//

import Foundation
import Alamofire

let BASE_URL = "https://travelcenter-api.onrender.com/app"
let DO_LOGIN = "/login"
let DO_REGISTER = "/register"
let GET_HOME_DATA = "/home"
let SEARCH_DESTINATIONS = "/search?term="
let GET_DESTINATION_DETAILS = "/destinationDetails/"
let GET_FAVORITES = "/favorites/"
let ADD_TO_FAVORITES = "/addFavorite"
let REMOVE_FAVORITE = "/removeFavorite/"
let SEND_RATING = "/destinationRating"

enum Endpoint {
    
    case doLogin(data: LoginModel)
    case doRegister(data: RegisterModel)
    case getHomeData
    case searchDestinations(term: String)
    case getDestinationDetails(id: String)
    case getFavorites(userId: String)
    case addFavorite(data: AddFavoriteModel)
    case removeFavorite(id: String)
    case sendRating(data: AddDestinationRatingModel)
    
    var endpoint: String {
        let endpoint = switch(self) {
        case .doLogin:
            DO_LOGIN
        case .doRegister:
            DO_REGISTER
        case .getHomeData:
            GET_HOME_DATA
        case .searchDestinations(term: let term):
            SEARCH_DESTINATIONS + term
        case .getDestinationDetails(id: let id):
            GET_DESTINATION_DETAILS + id
        case .getFavorites(userId: let userId):
            GET_FAVORITES + userId
        case .addFavorite:
            ADD_TO_FAVORITES
        case .removeFavorite(id: let id):
            REMOVE_FAVORITE + id
        case .sendRating:
            SEND_RATING
        }
        return BASE_URL + endpoint
    }
    
    var method: HTTPMethod {
        return switch(self) {
        case .doLogin,
             .doRegister,
             .addFavorite,
             .sendRating:
            HTTPMethod.post
        case .removeFavorite:
            HTTPMethod.delete
        default:
            HTTPMethod.get
        }
    }
    
    var authenticated: Bool {
        return switch (self) {
        case .addFavorite,
            .removeFavorite,
            .getFavorites,
            .sendRating,
            .getDestinationDetails:
            true
        default: 
            false
        }
    }
    
    var parameters: Codable? {
        return switch (self) {
        case .doLogin(data: let data):
            data
        case .doRegister(data: let data):
            data
        case .addFavorite(data: let data):
            data
        case .sendRating(data: let data):
            data
        case .getHomeData,
             .searchDestinations,
             .getDestinationDetails,
             .removeFavorite,
             .getFavorites:
            nil
        }
    }
    
    var responseType: Codable.Type? {
        return switch(self) {
        case .doLogin:
            UserModel.self
        case .doRegister:
            UserModel.self
        case .getHomeData:
            HomeDataModel.self
        case .searchDestinations:
            [DestinationSimpleModel].self
        case .getDestinationDetails:
            DestinationDetailsModel.self
        case .getFavorites:
            [DestinationSimpleModel].self
        case .addFavorite,
            .removeFavorite,
            .sendRating:
            nil
        }
    }
}
