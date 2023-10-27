//
//  AccountView.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 18/10/23.
//

import SwiftUI

struct AccountView: View {
    
    @ObservedObject var viewModel: AccountViewModel = AccountViewModel()
    
    var body: some View {
        VStack {
            switch(viewModel.event) {
            case .Loading:
                LoadingView()
                    .frame(height: maxHeight)
            case .Error(message: _):
                ErrorView {
                    viewModel.fetchUserData()
                }
            case .Reender(data: let model):
                if (model.isLogged) {
                    UserDataView(
                        model: model,
                        viewModel: viewModel
                    )
                } else {
                    NotLoggedView(completion: {
                        viewModel.fetchUserData()
                    })
                }
            }
        }.padding(
            EdgeInsets(
                top: mediumSpace,
                leading: 0,
                bottom: mediumSpace,
                trailing: 0
            )
        ).onAppear {
            viewModel.fetchUserData()
        }.frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        ).background(CustomColor.viewBackgroundColor)
    }
}

#Preview {
    AccountView()
}
