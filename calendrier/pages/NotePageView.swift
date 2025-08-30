//
//  NotePageView.swift
//  calendrier
//
//  Created by Krisha Patel on 2025-08-25.
//

import SwiftUI
import PhotosUI

struct NotePageView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var note: NoteModel? = nil
    
    @StateObject private var nVM = NotePageVM()
    
    init(note: NoteModel? = nil) {
        _nVM = StateObject(wrappedValue: NotePageVM(note: note))
    }

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        TextField("Title", text: $nVM.noteTitle)
                            .font(.DMSans(.largeTitle))
                            .foregroundStyle(Color.darkGrayBackground)
                            .fontWeight(.semibold)
                            .padding()
                        
                        SelectorButton(trigger: $nVM.isStarred, symbolTrue: "star.fill", symbolFalse:"star")
                    }
                
                    Text(getCurrentDateDetailed())
                        .font(.DMSans(.caption))
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 10)
                    
                    ZStack(alignment: .topLeading) {
                        if nVM.noteContent.isEmpty {
                            EmptyNoteContentView()
                        }
                        TextEditor(text: $nVM.noteContent)
                            .foregroundStyle(Color.darkGrayBackground)
                            .font(.DMSans(.callout))
                            .padding(.horizontal, 12)
                            .background(Color.clear)
                            .scrollContentBackground(.hidden)
                    }
                    .frame(minHeight: 500)
                    
                    
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .foregroundColor(Color.darkGrayBackground)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.softCream
                    .ignoresSafeArea()
            )
            .safeAreaInset(edge:.bottom) {
                //save/star button view
                Button((note == nil) ? "Save Note" : "Update Note") {
                    Task { await saveNote() }
                }
                .font(.DMSans(.title3))
                .fontWeight(.semibold)
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.offWhite)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.darkGrayBackground, lineWidth: 1)
                        )
                )
                .foregroundStyle(Color.darkGrayBackground)
                .padding(.horizontal, 50)
                .padding(.vertical, 20)
            }
            
        }
    }
    
    //MARK: Saves note
    //TODO: MODULARIZE PROPERLY (VM)
    private func saveNote() async {
        if let note = nVM.existingNote  {
            nVM.update(note: note, drawing: nil)
        } else { context.insert(nVM.newNoteR()) }
        do {
           try context.save()
           dismiss()
        } catch {
           print("Failed to save note:", error)
        }
    }
}


//MARK: Empty note content text view
private struct EmptyNoteContentView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Start typing your note...")
                    .font(.DMSans(.callout))
                    .foregroundStyle(.secondary)
                    .font(.body)
                Spacer()
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }
}


#Preview {
    NotePageView()
}

