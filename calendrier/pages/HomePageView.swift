//
//  HomePageView.swift
//  calendrier
//
//  Created by Krisha Patel on 2025-07-25.
//

import SwiftUI
import SwiftData
struct HomePageView: View {
    @StateObject private var hVM = HomeVM()
    @Environment(\.modelContext) private var context
    
    @Query var notes: [NoteModel]
    
    private var filteredNotes: [NoteModel] {
        switch hVM.filter {
        case .latest:
            return notes.sorted(by: { $0.modifiedDate > $1.modifiedDate })
        case .oldest:
            return notes.sorted(by: { $0.modifiedDate < $1.modifiedDate })
        case .starred:
            return notes.filter({ $0.isStarred })
        case .none:
            return notes
        }
    }

    var body: some View {
            VStack(alignment: .leading, spacing: 20){
                NavTitleView()
                DateCard()
                //Filter bar with deletion
                HStack {
                    FilterBar(selection: $hVM.filter)
                    //Delete button
                    Button {
                        withAnimation {
                            hVM.isDelete.toggle()
                        }
                    } label: {
                        Image(systemName:"trash.fill")
                            .font(.title2)
                            .foregroundStyle(hVM.isDelete ? Color.deepBlueAccent : Color.secondary)
                            .padding(.trailing, 27)
                    }
                }
                
                ScrollView {
                    ForEach(filteredNotes) { note in
                        SummaryCardSmall(summary: getSummary(summary: note.content), title: note.title, modDate: note.modifiedDate, deleteMode: hVM.isDelete, isStarred: note.isStarred, onDelete: {deleteNote(note:note)} )
                            .onTapGesture {
                                hVM.selectedNote = note
                                hVM.navigateNote = true
                                hVM.isDrawingNote = note.isDrawing
                            }
                    }
        
                    if filteredNotes.isEmpty {
                        Text("No notes yet...")
                            .font(.DMSans(.title3))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.deepBlueAccent)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.softCream
                .ignoresSafeArea()
        )
        .navigationDestination(isPresented: $hVM.navigateNote) {
            if hVM.isDrawingNote {
                NotePageDrawView(note: hVM.selectedNote)
                    .navigationBarBackButtonHidden(true)
            }
            else {
                NotePageView(note: hVM.selectedNote)
                    .navigationBarBackButtonHidden(true)
            }
        }
        .confirmationDialog("Select your note.", isPresented: $hVM.showingSheet, titleVisibility: .visible) {
            Button("Draw Note") { hVM.addNoteD() }
            Button("Text Note") { hVM.addNoteR() }
        }
        .safeAreaInset(edge: .bottom) {
            //'Add note' button
            TextBtn(action: {hVM.showingSheet = true}, text: "Add Note")
        }
        .onChange(of: hVM.navigateNote) {
            if !hVM.navigateNote {
                hVM.selectedNote = nil
                hVM.isDrawingNote = false
            }
        }

    }
    //TODO: Modularize properly
    private func deleteNote(note: NoteModel) -> Void {
        context.delete(note)
        do {
            try context.save()
        }
        catch {
            print("Failed to delete note:", error)
        }
    }
}

//MARK: Nav title view
private struct NavTitleView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("calendrier")
                .font(.DMSans(.title))
                .foregroundColor(Color.deepBlueAccent)
            Text("hey, how are you?")
                .padding(.horizontal, 3)
                .font(.DMSans(.caption2))
                .foregroundColor(Color.darkGrayBackground)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 35)
        .fontWeight(.semibold)
    }
}

#Preview {
    HomePageView()
}

