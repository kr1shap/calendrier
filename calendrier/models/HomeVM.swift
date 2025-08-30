//
//  HomeModel.swift
//  calendrier
//
//  Created by Krisha Patel on 2025-08-28.
//


import SwiftUI

@MainActor
class HomeVM: ObservableObject {
    @Published var isDelete: Bool = false   //deletion mode
    @Published var showingSheet: Bool = false   //showing selection sheet
    @Published var isDrawingNote: Bool = false  //selected note
    @Published var selectedNote: NoteModel? = nil
    @Published var navigateNote = false         //navigation bool to next page
    @Published var filter: FilterType = .none
    
    
    //MARK: Adding/new note function
    private func setNewNote() -> Void {
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
