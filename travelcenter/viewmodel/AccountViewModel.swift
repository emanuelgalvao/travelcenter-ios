//
//  AccountViewModel.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 21/10/23.
//

import Foundation

class AccountViewModel: ObservableObject {
    
    @Published private(set) var event: ViewEvent<AccountModel> = ViewEvent.Loading
    
    func fetchUserData() {
        event = ViewEvent.Loading
        let user = CoreDataManager.shared.getSavedUser()
        event = ViewEvent.Reender(
            data: AccountModel(
                isLogged: user != nil,
                userData: user
            )
        )
    }
    
    func doLogout() {
        event = ViewEvent.Loading
        CoreDataManager.shared.deleteSavedUser()
        event = ViewEvent.Reender(
            data: AccountModel(
                isLogged: false,
                userData: nil
            )
        )
    }
}
