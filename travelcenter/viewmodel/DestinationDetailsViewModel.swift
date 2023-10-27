//
//  DestinationDetailsViewModel.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 21/10/23.
//

import Foundation

class DestinationDetailsViewModel: ObservableObject {
    
    @Published private(set) var event: ViewEvent<DestinationDetailsViewData> = ViewEvent.Loading
    
    private var destinationModel: DestinationDetailsModel? = nil
    
    func fetchDestinationDetails(destinationId: String) {
        event = ViewEvent.Loading
        Api.shared.doRequest(
            endpoint: Endpoint.getDestinationDetails(id: destinationId),
            onSuccess: { model in
                let destinationModel = model as! DestinationDetailsModel
                self.destinationModel = destinationModel
                let data = DestinationDetailsViewData(
                    isLogged: CoreDataManager().isLogged(),
                    favoriteError: false,
                    data: destinationModel
                )
                self.event = ViewEvent.Reender(data: data)
                CoreDataManager.shared.saveDestinationOnHistory(
                    destinationId: destinationId,
                    destinationName: destinationModel.destinationInfo.name
                )
            }, onFailure: { error in
                self.event = ViewEvent.Error(message: error)
            }
        )
    }
    
    func addFavorite(destinationId: String) {
        event = ViewEvent.Loading
        Api.shared.doRequest(endpoint: .addFavorite(
            data: AddFavoriteModel(
                userId: CoreDataManager.shared.getUserId(),
                destinationId: destinationId
            )
        ), onSuccess: { model in
            self.fetchDestinationDetails(destinationId: destinationId)
        }, onFailure: { error in
            if let destination = self.destinationModel {
                self.event = ViewEvent.Reender(
                    data: DestinationDetailsViewData(
                        isLogged: CoreDataManager().isLogged(),
                        favoriteError: true,
                        data: destination
                    )
                )
            } else {
                self.event = ViewEvent.Error(message: error)
            }
        })
    }
    
    func removeFavorite(favoriteId: String, destinationId: String) {
        event = ViewEvent.Loading
        Api.shared.doRequest(
            endpoint: .removeFavorite(id: favoriteId),
            onSuccess: { model in
                self.fetchDestinationDetails(destinationId: destinationId)
            }, onFailure: { error in
                if let destination = self.destinationModel {
                    self.event = ViewEvent.Reender(
                        data: DestinationDetailsViewData(
                            isLogged: CoreDataManager().isLogged(),
                            favoriteError: true,
                            data: destination
                        )
                    )
                } else {
                    self.event = ViewEvent.Error(message: error)
                }
            }
        )
    }
}
