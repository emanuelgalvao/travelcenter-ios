//
//  RegisterViewModel.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 21/10/23.
//

import Foundation

class RegisterViewModel: ObservableObject {
    
    @Published private(set) var event: ViewEvent<UserModel> = ViewEvent.Error(message: nil)
    
    func doRegister(name: String, email: String, password: String, confirmPassword: String) {
        
        event = ViewEvent.Loading
        
        if let error = validateData(
            name: name,
            email: email,
            password: password,
            confirmPassword: confirmPassword
        ) {
            event = ViewEvent.Error(message: error)
        } else {
            let registerData = RegisterModel(name: name, email: email, password: password, confirmPassword: confirmPassword)
            
            Api.shared.doRequest(
                endpoint: Endpoint.doRegister(data: registerData),
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
    
    private func validateData(
        name: String,
        email: String,
        password: String,
        confirmPassword: String
    ) -> String? {
        
        var error: String? = nil
        
        if (name.isEmpty ||
            email.isEmpty ||
            password.isEmpty ||
            confirmPassword.isEmpty) {
            error = "Preencha todos os campos."
        } else if (!Validations.isValidName(name)) {
            error = "O nome deve possuir pelo menos 3 caracteres."
        } else if (!Validations.isValidEmail(email)) {
            error = "Insira um email válido."
        } else if (!Validations.isValidPassword(password)) {
            error = "Insira uma senha com pelo menos 5 caracteres."
        } else if (!Validations.isPasswordEquals(password, confirmPassword)) {
            error = "As senhas devem ser iguais."
        }
        
        return error
    }
}
