//
//  AddDestinationRatingViewModel.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 26/10/23.
//

import Foundation

class AddDestinationRatingViewModel: ObservableObject {
    
    @Published private(set) var event: ViewEvent<Void> = ViewEvent.Error(message: nil)
 
    func sendRating(destinationId: String, description: String, rate: Int) {
        event = ViewEvent.Loading
        let adjustedRate = rate + 1
        if let error = validateData(description: description, rate: adjustedRate) {
            event = ViewEvent.Error(message: error)
        } else {
            Api.shared.doRequest(
                endpoint: .sendRating(
                    data: AddDestinationRatingModel(
                        userId: CoreDataManager.shared.getUserId(),
                        destinationId: destinationId,
                        ratingText: description,
                        rate: adjustedRate
                    )
                ), onSuccess: { _ in
                    self.event = ViewEvent.Reender(data: Void())
                }, onFailure: { error in
                    self.event = ViewEvent.Error(message: error)
                }
            )
        }
    }
        
    private func validateData(description: String, rate: Int) -> String? {
        return if (!Validations.isValidRatingDescription(description)) {
            "A avaliação deve ter entre 10 e 250 caracteres."
        } else if (!Validations.isValidRatingRate(rate)) {
            "A avaliação deve ter entre 1 e 5 estrelas."
        } else {
            nil
        }
    }
}
