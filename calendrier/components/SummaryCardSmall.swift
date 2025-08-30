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
    var onDelete: () -> Void
   
    var body: some View {
        HStack(alignment: .center) {
            if deleteMode {
                Button {
                    onDelete()
                } label: {
                    Image(systemName:"x.circle.fill")
                        .font(.title)
                        .foregroundStyle(Color.deepBlueAccent)
                }
                .transition(.scale.combined(with: .opacity))

            }
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Image(.calendierNoteIcon)
                        .resizable()
                        .frame(width: 25, height: 25)
                    Text(title)
                        .foregroundStyle(Color.deepBlueAccent)
                        .fontWeight(.bold)
                        .font(.DMSans(.title3))
                        .lineLimit(2)
                        .truncationMode(.tail)
                        .padding(0)
                    Spacer()
                    if isStarred {
                        Image(systemName:"star.fill")
                            .font(.system(size: 20))
                            .foregroundStyle(Color.deepBlueAccent)
                    }
                    
                }
                .padding(0)
                
                Text(getModifiedDateDetailed(date: modDate))
                    .foregroundStyle(Color.secondary)
                    .font(.DMSans(.caption2))
                    .truncationMode(.tail)
                    .fontWeight(.light)
                    .padding(.bottom, 7)
                
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

#Preview {
    SummaryCardSmall(summary: "well ok this is a bit touch go do wel", title: "B09 Course Notes", modDate: Date(), deleteMode: false, isStarred: true, onDelete: {})
}


