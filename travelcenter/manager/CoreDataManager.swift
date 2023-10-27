//
//  CoreDataManager.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 21/10/23.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private let persistentContainer: NSPersistentContainer
    
    private let TWO_HOURS: CGFloat = 7200000
    
    init() {
        persistentContainer = NSPersistentContainer(name: "TravelCenterCoreDataModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error {
                fatalError("Falha ao inicializar o CoreDataManager -  \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: USER
    
    func saveUser(model: UserModel, password: String) {
        let user = UserEntity(context: persistentContainer.viewContext)
        
        user.id = model.id
        user.name = model.name
        user.email = model.email
        user.password = password
        user.token = model.token
        user.expirationAt = Int64((Date().timeIntervalSince1970 * 1000) + TWO_HOURS)
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Falha ao salvar o usuário - \(error)")
        }
    }
    
    func getSavedUser() -> UserModel? {
        let userEntity = getUserEntity()
        if let id = userEntity?.id,
           let name = userEntity?.name,
           let email = userEntity?.email,
           let token = userEntity?.token {
            return UserModel(
                id: id,
                name: name,
                email: email,
                token: token
            )
        } else {
            return nil
        }
    }
    
    func getLoginData() -> (email: String, password: String) {
        let userEntity = getUserEntity()
        return (userEntity?.email ?? "", userEntity?.password ?? "")
    }
    
    func deleteSavedUser() {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        do {
            let users = try persistentContainer.viewContext.fetch(fetchRequest)
            users.forEach { user in
                persistentContainer.viewContext.delete(user)
            }
            try persistentContainer.viewContext.save()
        } catch {
            print("Falha ao excluir o usuário - \(error)")
        }
        
    }
    
    func getUserId() -> String {
        return getUserEntity()?.id ?? ""
    }
    
    func getUserToken() -> String? {
        return if let userEntity = getUserEntity() {
            if (userEntity.expirationAt < Int64(Date().timeIntervalSince1970 * 1000)) {
                nil
            } else {
                userEntity.token
            }
        } else {
            nil
        }
    }
    
    func isLogged() -> Bool {
        return getSavedUser() != nil
    }
    
    private func getUserEntity() -> UserEntity? {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        do {
            let userEntity = try persistentContainer.viewContext.fetch(fetchRequest)
            return userEntity.first
        } catch {
            return nil
        }
    }
    
    // MARK: HISTORY
    
    func saveDestinationOnHistory(destinationId: String, destinationName: String) {
        let history = HistoryEntity(context: persistentContainer.viewContext)

        history.destinationId = destinationId
        history.destinationName = destinationName
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Falha ao salvar destino no histórico - \(error)")
        }
    }
        
    func getDestinationHistory() -> [DestinationSimpleModel] {
        
        var destinations: [DestinationSimpleModel] = []
        
        let fetchRequest: NSFetchRequest<HistoryEntity> = HistoryEntity.fetchRequest()
        
        do {
            let historyEntity = try persistentContainer.viewContext.fetch(fetchRequest)
            historyEntity.reversed().forEach { history in
                if let destinationId = history.destinationId,
                   let destinationName = history.destinationName {
                    destinations.append(
                        DestinationSimpleModel(
                            id: history.id.debugDescription,
                            destinationId: destinationId,
                            destinationName: destinationName
                        )
                    )
                }
            }
        } catch {
            print("Falha ao recuperar os destinos do histórico - \(error)")
        }
        return destinations
    }
}
