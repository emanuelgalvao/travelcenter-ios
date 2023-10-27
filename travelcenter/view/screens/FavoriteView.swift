//
//  FavoriteView.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 17/10/23.
//

import SwiftUI

struct FavoriteView: View {
    
    @ObservedObject var viewModel: FavoriteViewModel = FavoriteViewModel()
    
    var body: some View {
        VStack {
            switch(viewModel.event) {
            case .Loading:
                LoadingView()
            case .Error:
                ErrorView {
                    viewModel.fetchFavoriteData()
                }
            case let .Reender(data):
                Text("Favoritos")
                    .frame(
                        width: maxWidthWithPadding,
                        alignment: .leading
                    ).font(.title2)
                Spacer()
                if (data.isLogged) {
                    if let model = data.model {
                        if (model.isEmpty) {
                            Text("Nenhum destino favoritado ainda!")
                        } else {
                            DestinationSimpleListView(
                                destinations: model,
                                icon: "suit.heart"
                            )
                        }
                    }
                } else {
                    Text("Você não está logado!")
                    Text("Entre em sua conta para ver os favoritos!")
                }
                Spacer()
            }
        }.onAppear {
            viewModel.fetchFavoriteData()
        }.frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        ).background(CustomColor.viewBackgroundColor)
    }
}

#Preview {
    FavoriteView()
}
