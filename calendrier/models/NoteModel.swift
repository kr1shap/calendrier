//
//  NoteModel.swift
//  calendrier
//
//  Created by Krisha Patel on 2025-08-25.
//
import SwiftData
import SwiftUI

@Model
class NoteModel {
    var id: UUID
    @Attribute(.unique) var title: String
    var content: String
    var createdAt: Date
    var modifiedDate: Date
    var isStarred: Bool = false
    
    init(title: String, content: String, isStarred: Bool) {
        let currDate = Date()
        self.id = UUID()
        self.title = title
        self.content = content
        self.createdAt = currDate
        self.modifiedDate = currDate
        self.isStarred = isStarred
    }
    
    func updateModifiedDate() {
        self.modifiedDate = Date()
    }
}
