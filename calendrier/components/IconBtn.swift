//
//  IconBtn.swift
//  calendrier
//
//  Created by Krisha Patel on 2025-08-28.
//
import SwiftUI

struct IconBtn: View {
    var action: () -> Void
    var symbol: String
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(systemName:symbol)
            }
            .font(.title3)
            .foregroundStyle(Color.secondary)
            .padding(.vertical, 10)
        }
    }
}
