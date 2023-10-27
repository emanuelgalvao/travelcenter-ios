//
//  HomeViewModel.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 16/10/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published private(set) var event: ViewEvent<HomeDataModel> = ViewEvent.Loading

    func fetchHomeData() {
        event = ViewEvent.Loading
        Api.shared.doRequest(
            endpoint: Endpoint.getHomeData,
            onSuccess: { model in
                self.event = ViewEvent.Reender(data: model as! HomeDataModel)
            },
            onFailure: { error in
                self.event = ViewEvent.Error(message: error)
            }
        )
    }
}
