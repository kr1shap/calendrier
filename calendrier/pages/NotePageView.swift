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
    
    var note: NoteModel? = nil  //existing note

    @State private var noteTitle: String = ""
    @State private var noteContent: String = ""
    @State private var isStarred = false
    
    init(note: NoteModel? = nil) {
        self.note = note
        _noteTitle = State(initialValue: note?.title ?? "")
        _noteContent = State(initialValue: note?.content ?? "")
        _isStarred = State(initialValue: note?.isStarred ?? false)
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        TextField("Title", text: $noteTitle)
                            .font(.DMSans(.largeTitle))
                            .foregroundStyle(Color.darkGrayBackground)
                            .fontWeight(.semibold)
                            .padding()
                        
                        SelectorButton(trigger: $isStarred, symbolTrue: "star.fill", symbolFalse:"star")
                    }
                
                    Text(getCurrentDateDetailed())
                        .font(.DMSans(.caption))
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 10)
                    
                    ZStack(alignment: .topLeading) {
                        if noteContent.isEmpty {
                            EmptyNoteContentView()
                        }
                        TextEditor(text: $noteContent)
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
                    saveNote()
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
    private func saveNote() {
           if let note = note {
               note.title = noteTitle
               note.content = noteContent
               note.isStarred = isStarred
               note.updateModifiedDate()
           } else {
               let newNote = NoteModel(title: noteTitle, content: noteContent, isStarred: isStarred)
               context.insert(newNote)
           }
           do {
               try context.save()
               dismiss()
           } catch {
               print("Failed to save note:", error)
           }
    }
}


//MARK: Generic selector button to toggle option
private struct SelectorButton: View {
    @Binding var trigger: Bool
    var symbolTrue: String
    var symbolFalse: String
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.4)) {
                trigger.toggle()
            }
        } label: {
            HStack {
                Image(systemName: trigger ? symbolTrue : symbolFalse)
            }
            .font(.largeTitle)
            .foregroundStyle(Color.secondary)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)

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

