//
//  SelectorButton.swift
//  calendrier
//
//  Created by Krisha Patel on 2025-08-28.
//
import SwiftUI
struct SelectorButton: View {
    @Binding var trigger: Bool
    var symbolTrue: String
    var symbolFalse: String
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.4)) {
                trigger.toggle()
            }
        } label: {
            HStack {
                Image(systemName: trigger ? symbolTrue : symbolFalse)
            }
            .font(.largeTitle)
            .foregroundStyle(Color.secondary)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)

        }
    }
}
