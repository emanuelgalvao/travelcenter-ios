//
//  travelcenterApp.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 16/10/23.
//

import SwiftUI

@main
struct TravelCenterApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView().tabItem() {
                    Image(systemName: "house")
                    Text("Início")
                }
                HistoryView().tabItem() {
                    Image(systemName: "clock.arrow.circlepath")
                    Text("Histórico")
                }
                FavoriteView().tabItem() {
                    Image(systemName: "heart")
                    Text("Favoritos")
                }
                AccountView().tabItem() {
                    Image(systemName: "person")
                    Text("Conta")
                }
            }.onAppear {
                UITabBar.appearance().backgroundColor = CustomColor.tabViewBackgroundColor
                UITabBar.appearance().unselectedItemTintColor = CustomColor.tabViewItemColor
            }
        }
    }
}
