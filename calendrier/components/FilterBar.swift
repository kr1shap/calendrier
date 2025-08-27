//
//  FilterBar.swift
//  calendrier
//
//  Created by Krisha Patel on 2025-07-25.
//

import SwiftUI

struct FilterBar: View {
    @Binding var selection: FilterType
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(FilterType.visibleCases, id: \.self) { filter in
                Button(action: {
                    selection = filter
                }) {
                    FilterBtnLbl(
                        selected: filter.rawValue,
                        isSelected: selection == filter
                    )
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        
    }
}

#Preview {
    @Previewable @State var selection: FilterType = .none
    FilterBar(selection: $selection)
}
