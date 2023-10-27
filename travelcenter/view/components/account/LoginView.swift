//
//  LoginView.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 20/10/23.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var showLogin: Bool
    
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    
    @State var emailValue: String = ""
    @State var passwordValue: String = ""
    
    var body: some View {
        VStack {
            switch (viewModel.event) {
            case .Loading:
                LoadingView()
            case .Error(message: let message):
                Text("Entrar")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.accent)
                TextInput(
                    title: "Email:",
                    placeholder: "Insira o email",
                    value: $emailValue
                ).padding(
                    EdgeInsets(
                        top: mediumSpace,
                        leading: 0,
                        bottom: 0,
                        trailing: 0
                    )
                )
                TextInput(
                    title: "Senha:",
                    placeholder: "Insira a senha",
                    isSecure: true, 
                    value: $passwordValue
                ).padding(
                    EdgeInsets(
                        top: smallSpace,
                        leading: 0,
                        bottom: 0,
                        trailing: 0
                    )
                )
                if let message {
                    Text(message)
                        .padding(
                            EdgeInsets(
                                top: smallSpace,
                                leading: 0,
                                bottom: 0,
                                trailing: 0)
                        )
                }
                CustomButton(title: "Entrar") {
                    viewModel.doLogin(
                        email: emailValue,
                        password: passwordValue
                    )
                }.padding(
                    EdgeInsets(
                        top: mediumSpace,
                        leading: 0,
                        bottom: 0,
                        trailing: 0
                    )
                )
            case .Reender(data: let data):
                SuccessInsertView(
                    title: "Login realizado com sucesso.",
                    description: "Seja bem-vindo \(data.name)!",
                    completion: {
                        showLogin = false
                    }
                )
            }
        }
    }
}
