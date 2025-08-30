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
    var modDate: Date
    var deleteMode: Bool = false
    var isStarred: Bool
    var onDelete: () -> Void //function to call to delete the note
   
    var body: some View {
        HStack(alignment: .center) {
            //Delete mode button
            if deleteMode {
                DeleteButton(onDelete: {onDelete()})
            }
            //Main title contents
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Image(.calendierNoteIcon)
                        .resizable()
                        .frame(width: 25, height: 25)
                    Text(title)
                        .fontWeight(.bold)
                        .font(.DMSans(.title3))
                        .lineLimit(2)
                        .truncationMode(.tail)
                    Spacer()
                    if isStarred {
                        Image(systemName:"star.fill")
                            .font(.system(size: 20))
                    }
                    
                }
                .foregroundStyle(Color.deepBlueAccent)
                .padding(0)
                
                CardDate(modDate: modDate)
                
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
            .padding(.horizontal, deleteMode ? 10 : 0)

        }
        .padding(.vertical, 10)
        .padding(.horizontal, 30)
    }
}


//MARK: UI for showing the card date
private struct CardDate: View {
    var modDate: Date
    
    var body: some View {
        Text(getModifiedDateDetailed(date: modDate))
            .foregroundStyle(Color.secondary)
            .font(.DMSans(.caption2))
            .fontWeight(.light)
            .truncationMode(.tail)
            .padding(.bottom, 7)
    }
}

#Preview {
    SummaryCardSmall(summary: "well ok this is a bit touch go do wel", title: "B09 Course Notes", modDate: Date(), deleteMode: false, isStarred: true, onDelete: {})
}


