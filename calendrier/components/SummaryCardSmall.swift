//
//  SummaryCardSmall.swift
//  calendrier
//
//  Created by Krisha Patel on 2025-08-26.
//
import SwiftUI

struct SummaryCardSmall: View {
    var summary: String
    var title: String
   
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(.calendierNoteIcon)
                    .resizable()
                    .frame(width: 30, height: 30)
                Text(title)
                    .foregroundStyle(Color.deepBlueAccent)
                    .fontWeight(.bold)
                    .font(.DMSans(.title3))
                    .lineLimit(2)
                    .truncationMode(.tail)
            }
            
            Text(summary.isEmpty ? "No Content" : summary)
                .font(.DMSans(.callout))
                .lineLimit(4)
                .truncationMode(.tail)
        }
        .frame(maxWidth: .infinity, minHeight: 70, alignment: .topLeading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.offWhite)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.darkGrayBackground, lineWidth: 1)
                )
        )
        .padding(.vertical, 10)
        .padding(.horizontal, 30)

      
    }
}

#Preview {
    SummaryCardSmall(summary: "well ok this is a bit touch go do wel", title: "B09 Course Notes")
}


