//
//  LoginViewModel.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 21/10/23.
//

import Foundation
import CoreData

class LoginViewModel: ObservableObject {
    
    @Published private(set) var event: ViewEvent<UserModel> = ViewEvent.Error(message: nil)
    
    func doLogin(email: String, password: String) {

        event = ViewEvent.Loading
        
        if let error = validateData(email: email, password: password) {
            event = ViewEvent.Error(message: error)
        } else {
            let loginData = LoginModel(email: email, password: password)
            
            Api.shared.doRequest(
                endpoint: Endpoint.doLogin(data: loginData),
                onSuccess: { model in
                    let userModel = model as! UserModel
                    UserManager.saveUser(model: userModel, password: password)
                    self.event = ViewEvent.Reender(data: userModel)
                },
                onFailure: { error in
                    self.event = ViewEvent.Error(message: error)
                }
            )
        }
    }
    
    private func validateData(email: String, password: String) -> String? {
        return if (email.isEmpty || password.isEmpty) {
            "Preencha o email e a senha."
        } else {
            nil
        }
    }
}
