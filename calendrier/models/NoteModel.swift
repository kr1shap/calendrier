//
//  NoteModel.swift
//  calendrier
//
//  Created by Krisha Patel on 2025-08-25.
//
import Foundation
import SwiftData
import PencilKit

@Model
class NoteModel {
    var id: UUID
    var title: String
    var content: String
    var createdAt: Date
    var modifiedDate: Date
    var isStarred: Bool = false
    var drawing: Data?
    var isDrawing: Bool = false
    
    init(title: String, content: String, isStarred: Bool, drawingData: Data? = nil, _ isDrawing: Bool = false) {
        let currDate = Date()
        self.id = UUID()
        self.title = title
        self.content = content
        self.createdAt = currDate
        self.modifiedDate = currDate
        self.isStarred = isStarred
        self.drawing = drawingData
        self.isDrawing = isDrawing
    }
    
    func updateModifiedDate() {
        self.modifiedDate = Date()
    }
}
