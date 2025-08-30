//
//  ExtractedView.swift
//  calendrier
//
//  Created by Krisha Patel on 2025-08-30.
//

import SwiftUI

struct TextBtn: View {
    var action: () -> Void
    var text: String = "None"
    var body: some View {
        Button(text) {
            action()
        }
        .font(.DMSans(.title3))
        .fontWeight(.semibold)
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.offWhite)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.darkGrayBackground, lineWidth: 1)
                )
        )
        .foregroundColor(.darkGrayBackground)
        .padding(.horizontal, 50)
        .padding(.vertical, 20)
    }
}
