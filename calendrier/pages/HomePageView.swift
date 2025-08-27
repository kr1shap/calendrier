//
//  HomePageView.swift
//  calendrier
//
//  Created by Krisha Patel on 2025-07-25.
//

import SwiftUI
import SwiftData
struct HomePageView: View {
    @State private var selectedNote: NoteModel? = nil
    @State private var navigateNote = false
    @State private var filter: FilterType = .none
    @Environment(\.modelContext) private var context
    @Query(sort: \NoteModel.createdAt, order: .reverse) var notes: [NoteModel] = []
    
    var body: some View {
            VStack(alignment: .leading, spacing: 20){
                NavTitleView()
                DateCard()
                //TODO: add filters
                FilterBar(selection: $filter)

                //TODO: Show all notes
                ScrollView {
                    ForEach(notes) { note in
                        SummaryCardSmall(summary: getSummary(summary: note.content), title: note.title)
                            .onTapGesture {
                                selectedNote = note
                                navigateNote = true
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
        .navigationDestination(isPresented: $navigateNote) {
            NotePageView(note: selectedNote)
                .navigationBarBackButtonHidden(true)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.softCream
                .ignoresSafeArea()
        )
        .safeAreaInset(edge: .bottom) {
            //'Add note' button
            Button("Add note") {
                navigateNote = true
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

