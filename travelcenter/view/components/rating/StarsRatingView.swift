//
//  StarsRatingView.swift
//  travelcenter
//
//  Created by Emanuel Galvão on 25/10/23.
//

import SwiftUI

struct StarsRatingView: View {
    
    @Binding var selectedStar: Int
    
    private let starIconSize: CGFloat = 30
    
    var body: some View {
        HStack(spacing: smallSpace) {
            ForEach(0..<5) { star in
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(
                        width: starIconSize,
                        height: starIconSize
                    ).foregroundColor(
                        self.selectedStar >= star ? .yellow : .gray
                    ).onTapGesture {
                        self.selectedStar = star
                    }
            }
        }
    }
}
