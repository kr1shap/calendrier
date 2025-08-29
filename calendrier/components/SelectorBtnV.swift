//
//  SelectorBtnV.swift
//  calendrier
//
//  Created by Krisha Patel on 2025-08-28.
//
import SwiftUI

struct SelectorBtnV: View {
    @Binding var trigger: Bool
    var symbolTrue: String
    var symbolFalse: String
    var col: Color = Color.secondary
    var size: CGFloat = 15
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.4)) {
                trigger.toggle()
            }
        } label: {
            HStack {
                Image(systemName: trigger ? symbolTrue : symbolFalse)
            }
            .font(.system(size: size))
            .foregroundStyle(col)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)

        }
    }
}
