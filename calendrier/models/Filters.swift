//
//  Filters.swift
//  calendrier
//
//  Created by Krisha Patel on 2025-08-27.
//
import Foundation

enum FilterType: String, Hashable, CaseIterable {
    case none
    case latest
    case oldest
    case starred
    
    static var visibleCases: [FilterType] {
        allCases.filter { $0 != .none }
    }
}
