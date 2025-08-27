//
//  utils.swift
//  calendrier
//
//  Created by Krisha Patel on 2025-08-26.
//
import SwiftUI
import Foundation

func getCurrentDate() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d"
    return formatter.string(from: Date())
}

func getCurrentDateDetailed() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM d, yyyy 'at' h:mm a"
    return formatter.string(from: Date())
}

func getSummary(summary: String) -> String {
    let truncatedContent: String
    if summary.count > 20 {
        truncatedContent = summary.prefix(20) + "…"
    } else {
        return summary
    }
    return truncatedContent
}
