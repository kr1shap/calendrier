//
//  FilterBtnLbl.swift
//  calendrier
//
//  Created by Krisha Patel on 2025-08-25.
//

import SwiftUI

struct FilterBtnLbl: View {
    var selected: String
    var isSelected: Bool = false //default false
    
    var body: some View {
       HStack(spacing: 8) {
           Text(selected)
               .font(.DMSans(.subheadline))
               .fontWeight(.medium)
               .foregroundStyle(isSelected ? Color.offWhite : Color.darkGrayBackground)

       }
       .padding(.vertical, 8)
       .padding(.horizontal, 15)
       .background(
           RoundedRectangle(cornerRadius: 20)

               .fill(isSelected ? Color.deepBlueAccent : Color.offWhite)
               .overlay(
                   RoundedRectangle(cornerRadius: 20)
                       .stroke(Color.darkGrayBackground, lineWidth: 1)
               )
       )
   }
}

#Preview {
    FilterBtnLbl(selected:"starred", isSelected: true)
}
