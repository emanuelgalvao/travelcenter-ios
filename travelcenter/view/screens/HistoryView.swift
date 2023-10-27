//
//  HistoryView.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 17/10/23.
//

import SwiftUI

struct HistoryView: View {
    
    @ObservedObject var viewModel: HistoryViewModel = HistoryViewModel()
    
    var body: some View {
        VStack {
            switch(viewModel.event) {
            case .Loading:
                LoadingView()
            case .Error:
                Text("Ocorreu um erro!")
                CustomButton(title: "Tentar novamente") {
                    viewModel.fetchHistoryData()
                }
            case let .Reender(data):
                Text("Histórico")
                    .frame(
                        width: maxWidthWithPadding,
                        alignment: .leading
                    ).font(.title2)
                Spacer()
                if (data.isEmpty) {
                    Text("Nenhum histórico de destinos visualizados!")
                } else {
                    DestinationSimpleListView(
                        destinations: data,
                        icon: "map"
                    )
                }
                Spacer()
            }
        }.onAppear {
            viewModel.fetchHistoryData()
        }.frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        ).background(CustomColor.viewBackgroundColor)
    }
}

#Preview {
    HistoryView()
}
