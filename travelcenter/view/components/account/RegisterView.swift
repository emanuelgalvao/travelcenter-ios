//
//  RegisterView.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 18/10/23.
//

import SwiftUI
struct RegisterView: View {
    
    @Binding var showRegister: Bool
    
    @ObservedObject var viewModel: RegisterViewModel = RegisterViewModel()
    
    @State var nameValue: String = ""
    @State var emailValue: String = ""
    @State var passwordValue: String = ""
    @State var confirmPasswordValue: String = ""
    
    var body: some View {
        VStack {
            switch (viewModel.event) {
            case .Loading:
                LoadingView()
            case .Error(message: let message):
                Text("Cadastre-se")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.accent)
                TextInput(
                    title: "Nome:",
                    placeholder: "Insira o nome",
                    value: $nameValue
                ).padding(
                    EdgeInsets(
                        top: mediumSpace,
                        leading: 0,
                        bottom: 0,
                        trailing: 0
                    )
                )
                TextInput(
                    title: "Email:",
                    placeholder: "Insira o email",
                    value: $emailValue
                ).padding(
                    EdgeInsets(
                        top: smallSpace,
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
                TextInput(
                    title: "Confirmar Senha:",
                    placeholder: "Insira a senha novamente",
                    isSecure: true,
                    value: $confirmPasswordValue
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
                CustomButton(title: "Cadastrar") {
                    viewModel.doRegister(
                        name: nameValue,
                        email: emailValue,
                        password: passwordValue,
                        confirmPassword: confirmPasswordValue
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
                    title: "Cadastro realizado com sucesso.",
                    description: "Seja bem-vindo \(data.name)!",
                    completion: {
                        showRegister = false
                    }
                )
            }
        }
    }
}
