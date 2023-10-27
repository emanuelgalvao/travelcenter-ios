//
//  UserManager.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 21/10/23.
//

import Foundation

struct UserManager {
    
    static func saveUser(model: UserModel, password: String) {
        CoreDataManager.shared.deleteSavedUser()
        CoreDataManager.shared.saveUser(
            model: UserModel(
                id: model.id,
                name: model.name,
                email: model.email,
                token: model.token
            ),
            password: password
        )
    }
}
