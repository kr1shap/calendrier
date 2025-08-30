//
//  DateCard.swift
//  calendrier
//
//  Created by Krisha Patel on 2025-08-25.
//
import SwiftUI

struct DateCard: View {
    //TODO: Crashes when I remove date?
    var date = Date()
    var body: some View {
        HStack(alignment: .center, spacing: 50) {
            Image(.calendrierYellowIcon)
                .resizable()
                .frame(width: 125, height: 125)
            //Date
            VStack {
                Text(Date.now, format: .dateTime.day().month())
                    .foregroundStyle(Color.deepBlueAccent)
                    .fontWeight(.bold)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .truncationMode(.tail)
                
                Text(Date.now, format: .dateTime.year())
                    .foregroundStyle(Color.deepBlueAccent)
                    .fontWeight(.bold)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .truncationMode(.tail)
            }
            
            
        }
        .frame(maxWidth: .infinity, minHeight: 140)
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.softYellow)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.darkGrayBackground, lineWidth: 1)
                )
        )
        .padding(.horizontal, 30)

      
    }
}

#Preview {
    DateCard()
}
