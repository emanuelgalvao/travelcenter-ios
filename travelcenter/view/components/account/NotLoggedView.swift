//
//  NotLoggedView.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 19/10/23.
//

import SwiftUI

struct NotLoggedView: View {
    
    let completion: () -> Void
    
    @State private var showLogin: Bool = false
    @State private var showRegister: Bool = false
    
    var body: some View {
        VStack {
            Image(systemName: "person.fill.xmark")
                .scaleEffect(largeImageScale)
                .frame(
                    width: largeImageSize,
                    height: largeImageSize
                )
            Text("Que pena!")
                .font(.title2)
            Text("Você não está logado!")
                .font(.title2)
            CustomButton(title: "Fazer login") {
                showLogin = true
            }
            CustomButton(title: "Criar uma conta") {
                showRegister = true
            }
        }.sheet(
            isPresented: $showLogin,
            onDismiss: {
                completion()
            },
            content: {
                VStack {
                    LoginView(showLogin: $showLogin)
                }.frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                ).background(CustomColor.viewBackgroundColor)
            }
        ).sheet(
            isPresented: $showRegister,
            onDismiss: {
                completion()
            },
            content: {
                VStack {
                    RegisterView(showRegister: $showRegister)
                }.frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                ).background(CustomColor.viewBackgroundColor)
            }
        )
    }
}

#Preview {
    NotLoggedView(completion: {
        
    })
}
