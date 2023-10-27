//
//  ContentView.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 16/10/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
    
    @State var showSheet: Bool = WelcomeManager.shared.showWelcomeMessage()
    
    var body: some View {
        VStack {
            switch(viewModel.event) {
            case .Loading:
                LoadingView()
            case .Error:
                ErrorView {
                    viewModel.fetchHomeData()
                }
            case let .Reender(data):
                Text("Olá, bem-vindo(a)!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.accent)
                    .frame(
                        width: maxWidthWithPadding,
                        alignment: .leading
                    )
                DestinationTypesView(destinationTypes: data.destinationTypes)
                HStack {
                    Image(systemName: "lightbulb.max")
                        .padding(
                            EdgeInsets(
                                top: mediumSpace,
                                leading: mediumSpace,
                                bottom: mediumSpace,
                                trailing: 0
                            )
                        )
                    Text(data.tip)
                        .padding(
                            EdgeInsets(
                                top: smallSpace,
                                leading: smallSpace,
                                bottom: smallSpace,
                                trailing: mediumSpace
                            )
                        )
                }.frame(
                    width: maxWidthWithPadding,
                    alignment: .leading
                ).background(.white)
                .cornerRadius(defaultCornerRadius)
                .padding(
                    EdgeInsets(
                        top: smallSpace,
                        leading: 0,
                        bottom: 0,
                        trailing: 0
                    )
                )
                ForEach(data.sections, id: \.self.name) { section in
                    HomeSectionView(section: section)
                        .padding(
                            EdgeInsets(
                                top: smallSpace,
                                leading: 0,
                                bottom: 0,
                                trailing: 0
                            )
                        )
                }
                Spacer()
            }
        }.onAppear {
            viewModel.fetchHomeData()
        }.frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        ).background(CustomColor.viewBackgroundColor)
        .sheet(isPresented: $showSheet, content: {
            WelcomeView(showSheet: $showSheet)
        })
    }
}

#Preview {
    HomeView()
}
