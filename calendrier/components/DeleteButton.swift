//
//  DeleteButton.swift
//  calendrier
//
//  Created by Krisha Patel on 2025-08-30.
//
import SwiftUI

struct DeleteButton: View {
    var onDelete: () -> Void
    
    var body: some View {
        Button {
            onDelete()
        } label: {
            Image(systemName: "x.circle.fill")
                .font(.title)
                .foregroundStyle(Color.deepBlueAccent)
        }
        .transition(.scale.combined(with: .opacity))
    }
}
