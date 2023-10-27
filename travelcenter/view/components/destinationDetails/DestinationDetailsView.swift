//
//  DestinationDetailsView.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 20/10/23.
//

import SwiftUI

struct DestinationDetailsView: View {
    
    let destinationId: String
    
    @ObservedObject var viewModel: DestinationDetailsViewModel = DestinationDetailsViewModel()
    
    @State var showSheet: Bool = false
    @State var ratingText: String = ""
    
    private let photoHeight: CGFloat = 200
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                switch(viewModel.event) {
                case .Loading:
                    LoadingView()
                        .frame(
                            width: maxWidth,
                            height: maxHeight
                        )
                case .Error(message: _):
                    ErrorView() {
                        viewModel.fetchDestinationDetails(destinationId: destinationId)
                    }.frame(height: maxHeight)
                case .Reender(data: let model):
                    AsyncImage(
                        url: URL(string: model.data.destinationInfo.photoUrl),
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(
                                    width: maxWidthWithPadding,
                                    height: photoHeight
                                )
                                .cornerRadius(defaultCornerRadius)
                        },
                        placeholder: {
                            ProgressView()
                                .frame(height: photoHeight)
                        }
                    ).padding(
                        EdgeInsets(
                            top: mediumSpace,
                            leading: 0,
                            bottom: 0,
                            trailing: 0
                        )
                    )
                    Text(model.data.destinationInfo.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(
                            width: maxWidthWithPadding,
                            alignment: .leading
                        ).padding(
                            EdgeInsets(
                                top: smallSpace,
                                leading: 0,
                                bottom: 0,
                                trailing: 0
                            )
                        )
                    Text(model.data.destinationInfo.description)
                        .frame(
                            width: maxWidthWithPadding,
                            alignment: .leading
                        )
                    if (model.isLogged) {
                        if (model.data.destinationInfo.favoriteId.isEmpty) {
                            CustomButton(title: "Adicionar aos favoritos") {
                                viewModel.addFavorite(destinationId: destinationId)
                            }
                        } else {
                            CustomButton(
                                title: "Remover dos favoritos",
                                style: .negative
                            ) {
                                viewModel.removeFavorite(favoriteId: model.data.destinationInfo.favoriteId, destinationId: destinationId)
                            }
                        }
                        if (model.favoriteError) {
                            Text("Ocorreu um error ao \(model.data.destinationInfo.favoriteId.isEmpty ? "adicionar" : "remover") o favorito.")
                        }
                    }
                    if (!model.data.destinationAttractions.isEmpty) {
                        Text("Atrações turisticas")
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(
                                width: maxWidthWithPadding,
                                alignment: .leading
                            ).padding(
                                EdgeInsets(
                                    top: smallSpace,
                                    leading: 0,
                                    bottom: 0,
                                    trailing: 0
                                )
                            )
                        MapView(attractions: model.data.destinationAttractions)
                    }
                    HStack {
                        Text("Avaliações de usuários")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(
                                EdgeInsets(
                                    top: smallSpace,
                                    leading: 0,
                                    bottom: 0,
                                    trailing: 0
                                )
                            )
                        Spacer()
                        Text(model.data.destinationInfo.rate)
                            .font(.title2)
                            .fontWeight(.bold)
                        Image(systemName: "star.fill")
                            .font(.title2)
                    }.frame(
                        width: maxWidthWithPadding,
                        alignment: .leading
                    )
                    if (model.data.ratings.isEmpty) {
                        Text("Nenhuma avaliação adicionada ainda!")
                            .padding(
                                EdgeInsets(
                                    top: smallSpace,
                                    leading: 0,
                                    bottom: 0,
                                    trailing: 0
                                )
                            )
                    } else {
                        LazyVStack {
                            ForEach(model.data.ratings, id: \.self.id) { rating in
                                DestinationRatingView(rating: rating)
                            }
                        }
                    }
                    if (model.isLogged) {
                        CustomButton(title: "Escrever Avaliação") {
                            showSheet = true
                        }.padding(
                            EdgeInsets(
                                top: mediumSpace,
                                leading: 0,
                                bottom: mediumSpace,
                                trailing: 0
                            )
                        )
                    }
                }
            }
        }.onAppear {
            viewModel.fetchDestinationDetails(destinationId: destinationId)
        }.sheet(
            isPresented: $showSheet,
            onDismiss: {
                viewModel.fetchDestinationDetails(destinationId: destinationId)
            },
            content: {
                VStack {
                    AddDestinationRatingView(
                        destinationId: destinationId,
                        showSheet: $showSheet
                    )
                }.frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                ).background(CustomColor.viewBackgroundColor)
            }
        ).frame(width: maxWidth)
        .background(.viewBackground)
    }
}

#Preview {
    DestinationDetailsView(destinationId: "")
}
