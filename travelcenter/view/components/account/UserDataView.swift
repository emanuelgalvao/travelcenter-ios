//
//  UserDataView.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 19/10/23.
//

import SwiftUI

struct UserDataView: View {
    
    let model: AccountModel
    let viewModel: AccountViewModel
    
    var body: some View {
        Image(systemName: "person")
            .scaleEffect(largeImageScale)
            .frame(
                width: largeImageSize,
                height: largeImageSize
            )
        Text("Minha Conta")
            .font(.title2)
            .fontWeight(.bold)
        VStack {
            Text("Nome: \(model.userData?.name ?? "")")
                .padding(
                    EdgeInsets(
                        top: smallSpace,
                        leading: mediumSpace,
                        bottom: 0,
                        trailing: mediumSpace
                    )
                )
                .frame(
                    width: maxWidthWithPadding,
                    alignment: .leading
                )
            Text("Email: \(model.userData?.email ?? "")")
                .padding(
                    EdgeInsets(
                        top: smallSpace,
                        leading: mediumSpace,
                        bottom: smallSpace,
                        trailing: mediumSpace
                    )
                ).frame(
                    width: maxWidthWithPadding, 
                    alignment: .leading
                )
        }.frame(
            width: maxWidthWithPadding
        ).padding(smallSpace)
        .background(.white)
        .cornerRadius(defaultCornerRadius)
        Spacer()
        CustomButton(title: "Sair", style: .negative) {
            viewModel.doLogout()
        }
    }
}

#Preview {
    UserDataView(
        model: AccountModel(
            isLogged: true,
            userData: UserModel(
                id: "Id",
                name: "Name",
                email: "Email",
                token: ""
            )
        ),
        viewModel: AccountViewModel()
    )
}
