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
//    @Query(sort: [SortDescriptor(\NoteModel.createdAt, order: .reverse)])
//    var notes: [NoteModel]

    @Query(sort: [SortDescriptor(\NoteModel.createdAt, order: .reverse)])
    var notes: [NoteModel]
//
//    @Query(
//        filter: #Predicate { $0.isStarred == true },
//        sort: [SortDescriptor(\NoteModel.createdAt, order: .reverse)]
//    )
//    var starredNotes: [NoteModel]
//
//    @Query(sort: [SortDescriptor(\NoteModel.modifiedDate, order: .reverse)])
//    var latestNotes: [NoteModel]
//
//    @Query(sort: [SortDescriptor(\NoteModel.modifiedDate, order: .forward)])
//    var oldestNotes: [NoteModel]
//

    // Selected notes state
//    private var selNotes: [NoteModel] {
//        switch hVM.filter {
//        case .latest: return latestNotes
//        case .oldest: return oldestNotes
//        case .starred: return starredNotes
//        case .none: return notes
//        }
//    }


    
    var body: some View {
            VStack(alignment: .leading, spacing: 20){
                NavTitleView()
                DateCard()
                //TODO: make filters work
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
                    ForEach(notes) { note in
                        SummaryCardSmall(summary: getSummary(summary: note.content), title: note.title, modDate: note.modifiedDate, deleteMode: hVM.isDelete, onDelete: {deleteNote(note:note)} )
                            .onTapGesture {
                                hVM.selectedNote = note
                                hVM.navigateNote = true
                            }
                    }
        
                    if notes.isEmpty {
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
            Button("Draw Note") {
                hVM.addNoteD()
            }
            Button("Text Note") {
                hVM.addNoteR()
            }
        }
        .safeAreaInset(edge: .bottom) {
            //'Add note' button
            Button("Add note") {
                hVM.showingSheet = true
            }
            .font(.DMSans(.title3))
            .fontWeight(.semibold)
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.offWhite)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.darkGrayBackground, lineWidth: 1)
                    )
            )
            .foregroundColor(.darkGrayBackground)
            .padding(.horizontal, 50)
            .padding(.vertical, 20)
        }
//        .onChange(of: hVM.filter) {
//            switch hVM.filter {
//            case .latest:
//                selNotes = latestNotes
//            case .oldest:
//                selNotes = oldestNotes
//            case .starred:
//                selNotes = starredNotes
//            case .none:
//                selNotes = notes
//            }
//        }
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

