//
//  Filters.swift
//  calendrier
//
//  Created by Krisha Patel on 2025-08-27.
//

enum FilterType: String, Hashable, CaseIterable {
    case none
    case latest
    case oldest
    case starred
    
    //All filters (except the 'none' default case)
    static var visibleCases: [FilterType] {
        allCases.filter { $0 != .none }
    }
}
