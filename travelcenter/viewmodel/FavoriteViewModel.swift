//
//  FavoriteViewModel.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 20/10/23.
//

import Foundation

struct FavoriteViewData {
    let isLogged: Bool
    let model: [DestinationSimpleModel]?
}

class FavoriteViewModel: ObservableObject {
    
    @Published private(set) var event: ViewEvent<FavoriteViewData> = ViewEvent.Loading
    
    func fetchFavoriteData() {
        event = ViewEvent.Loading
        if (CoreDataManager.shared.isLogged()) {
            Api.shared.doRequest(
                endpoint: .getFavorites(
                    userId: CoreDataManager.shared.getUserId()
                ),
                onSuccess: { model in
                    self.event = ViewEvent.Reender(
                        data: FavoriteViewData(
                            isLogged: true,
                            model: model as! [DestinationSimpleModel]
                        )
                    )
                }, onFailure: { error in
                    self.event = ViewEvent.Error(message: error)
                })
        } else {
            event = ViewEvent.Reender(data: FavoriteViewData(isLogged: false, model: nil))
        }
    }
}
