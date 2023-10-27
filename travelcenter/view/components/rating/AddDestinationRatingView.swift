//
//  DestinationRatingView.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 25/10/23.
//

import SwiftUI

struct AddDestinationRatingView: View {
    
    let destinationId: String
    @Binding var showSheet: Bool
    
    @ObservedObject var viewModel: AddDestinationRatingViewModel = AddDestinationRatingViewModel()
    
    @State var selectedStar: Int = -1
    @State var ratingText: String = ""
    
    private let textEditorHeight: CGFloat = 150
    
    var body: some View {
        VStack {
            switch (viewModel.event) {
            case .Loading:
                LoadingView()
            case .Error(message: let message):
                Text("Adicionar avaliação")
                    .padding(mediumSpace)
                    .font(.title2)
                TextEditor(text: $ratingText)
                    .frame(
                        width: maxWidthWithPadding,
                        height: textEditorHeight
                    ).scrollContentBackground(.hidden)
                    .background(.white)
                    .cornerRadius(defaultCornerRadius)
                StarsRatingView(selectedStar: $selectedStar)
                    .padding(
                        EdgeInsets(
                            top: mediumSpace,
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
                Spacer()
                CustomButton(title: "Enviar avaliação") {
                    viewModel.sendRating(
                        destinationId: destinationId,
                        description: ratingText,
                        rate: selectedStar
                    )
                }.padding(
                    EdgeInsets(
                        top: 0,
                        leading: mediumSpace,
                        bottom: mediumSpace,
                        trailing: mediumSpace
                    )
                )
            case .Reender(data: _):
                SuccessInsertView(
                    title: "Avaliação enviada com sucesso.",
                    description: "Obrigado pela avaliação!",
                    completion: {
                        showSheet = false
                    }
                )
            }
        }.presentationDetents([.medium])
    }
}
