//
//  TextInput.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 16/10/23.
//

import SwiftUI

struct TextInput: View {
    
    var title: String = ""
    var placeholder: String = ""
    
    var isSecure: Bool = false
    
    @Binding var value: String
    
    private let lineLimit: Int = 1
    
    var body: some View {
        VStack {
            if !title.isEmpty {
                Text(title)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
            }
            if (isSecure) {
                SecureField(
                    placeholder,
                    text: $value
                )
                .textFieldStyle(.roundedBorder)
                .lineLimit(lineLimit)
            } else {
                TextField(
                    placeholder,
                    text: $value
                )
                .textFieldStyle(.roundedBorder)
                .lineLimit(lineLimit)
            }
        }.padding(
            EdgeInsets(
                top: 0,
                leading: mediumSpace,
                bottom: 0,
                trailing: mediumSpace
            )
        )
    }
}
