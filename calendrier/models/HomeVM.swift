//
//  HomeModel.swift
//  calendrier
//
//  Created by Krisha Patel on 2025-08-28.
//


import SwiftUI

@MainActor
class HomeVM: ObservableObject {
    
    @Published var isDelete: Bool = false
    @Published var showingSheet: Bool = false
    @Published var isDrawingNote: Bool = false
    @Published var selectedNote: NoteModel? = nil
    @Published var navigateNote = false
    @Published var filter: FilterType = .none
    
    
    func setNewNote() -> Void {
        navigateNote = true
        selectedNote = nil
    }

    func addNoteD() -> Void {
        isDrawingNote = true
        setNewNote()
    }
    
    func addNoteR() -> Void {
        isDrawingNote = false
        setNewNote()
    }
    
   
}
