//
//  NotePageVM.swift
//  calendrier
//
//  Created by Krisha Patel on 2025-08-28.
//

import SwiftUI
import PencilKit
@MainActor
class NotePageVM: ObservableObject {
    @Published var noteTitle: String = ""
    @Published var noteContent: String = ""
    @Published var isStarred = false
    
    @Published var existingNote: NoteModel?

    init(note: NoteModel? = nil) {
        self.noteTitle = note?.title ?? ""
        self.noteContent = note?.content ?? ""
        self.isStarred = note?.isStarred ?? false
        self.existingNote = note
            
    }
    
    private func getTitle() -> String {
        noteTitle.isEmpty ? "No title" : noteTitle
    }
    
    private func getContent(_ forDrawing: Bool = false) -> String {
        if forDrawing {
            return "Drawing Content..."
        } else {
            return noteContent.isEmpty ? "No content" : noteContent
        }
    }
    
    func update(note: NoteModel, drawing: PKDrawing?, _ isDrawing: Bool = false) -> Void {
        note.title = getTitle()
        note.content = getContent(note.isDrawing)
        note.isStarred = isStarred
        note.updateModifiedDate()
        note.isDrawing = isDrawing
        if note.isDrawing { note.drawing = drawing?.dataRepresentation()}
        else {note.drawing = nil}
    }
    
    func newNoteD(drawing: PKDrawing) -> NoteModel {
        return NoteModel(title: getTitle(), content: getContent(true), isStarred: isStarred, drawingData: drawing.dataRepresentation(), true)
    }
    
    func newNoteR() -> NoteModel {
        return NoteModel(title: getTitle(), content: getContent(), isStarred: isStarred, false)
    }
    
    func loadDrawing() -> PKDrawing {
        guard let data = existingNote?.drawing else { return PKDrawing() }
        do {
            let drawing = try PKDrawing(data: data)
            return drawing
        } catch {
            print("Failed to load drawing:", error)
            return PKDrawing()
        }
    }
    
}
