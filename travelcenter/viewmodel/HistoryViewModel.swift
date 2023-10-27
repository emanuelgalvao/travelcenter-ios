//
//  HistoryViewModel.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 20/10/23.
//

import Foundation

class HistoryViewModel: ObservableObject {
    
    @Published private(set) var event: ViewEvent<[DestinationSimpleModel]> = ViewEvent.Loading
    
    func fetchHistoryData() {
        let historyDestinations = CoreDataManager.shared.getDestinationHistory()
        event = ViewEvent<[DestinationSimpleModel]>.Reender(
            data: historyDestinations
        )
    }
}
