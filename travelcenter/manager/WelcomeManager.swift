//
//  WelcomeManager.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 26/10/23.
//

import Foundation

struct WelcomeManager {
    
    static let shared = WelcomeManager()
    
    private let showedWelcomeMessageKey = "ShowedWelcomeMessage"
    
    func showWelcomeMessage() -> Bool {
        return !UserDefaults.standard.bool(forKey: showedWelcomeMessageKey)
    }
    
    func setShowedWelcomeMessage() {
        UserDefaults.standard.set(true, forKey: showedWelcomeMessageKey)
    }
}
