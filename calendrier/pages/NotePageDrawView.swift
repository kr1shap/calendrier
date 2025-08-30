//
//  NotePageDrawView.swift
//  calendrier
//
//  Created by Krisha Patel on 2025-08-28.
//

import SwiftUI
import PencilKit
import SwiftData

struct NotePageDrawView: View {
    //Model, dismiss note, focus state
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    //Drawing variables
    @State private var drawing = PKDrawing()
    @State private var toolPicker = PKToolPicker()
    @Environment(\.undoManager) private var undoManager
    
    var note: NoteModel? = nil  //existing note

    @StateObject private var dVM = NotePageVM()
    
    //Initalize state object
    init(note: NoteModel? = nil) {
        _dVM = StateObject(wrappedValue: NotePageVM(note: note))
    }
    
    var body: some View {
            VStack {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        TextField("Title", text: $dVM.noteTitle)
                            .font(.DMSans(.largeTitle))
                            .foregroundStyle(Color.darkGrayBackground)
                            .fontWeight(.semibold)
                            .padding()
                        
                        SelectorButton(trigger: $dVM.isStarred, symbolTrue: "star.fill", symbolFalse:"star")
                        
                        //Undo, redo buttons
                        HStack {
                            IconBtn(action: { undoManager?.undo() }, symbol:"arrow.uturn.backward")
                            IconBtn(action: { undoManager?.redo() } , symbol:"arrow.uturn.forward")
                        }
                        .padding(.trailing, 15)
                    }
                
                    Text(getCurrentDateDetailed())
                        .font(.DMSans(.caption))
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 10)
                    
                }
                // Drawing Canvas
                ZStack {
                    DrawingCanvas(toolPicker: toolPicker, drawing: $drawing)
                        .background(Color.softCream)
                    
                    VStack {
                        Spacer()
                        Button((note == nil) ? "Save Note" : "Update Note") {
                            Task {
                                await saveNoteDraw()
                            }
                        }
                        .font(.DMSans(.title3))
                        .fontWeight(.semibold)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 10)
                        .frame(maxWidth: .infinity)
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
                        .padding(.bottom, 100)
                    }
                }


            }
            .onAppear {
                drawing = dVM.loadDrawing()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.softCream
                    .ignoresSafeArea()
            )

    }
    
    //MARK: Saves note
    //TODO: MODULARIZE PROPERLY (VM)
    private func saveNoteDraw() async {
           if let note = dVM.existingNote {
               dVM.update(note:note, drawing: drawing, true)
           } else { context.insert(dVM.newNoteD(drawing: drawing)) }
           do {
               try context.save()
               dismiss()
           } catch {
               print("Failed to save note:", error)
           }
    }
    
}



// Drawing Canvas wrapper
//struct DrawingCanvas: UIViewRepresentable {
//    let toolPicker: PKToolPicker
//    @Binding var drawing: PKDrawing
//
//    
//    func makeUIView(context: Context) -> PKCanvasView {
//        let canvasView = PKCanvasView()
//        canvasView.drawingPolicy = .anyInput
//        canvasView.tool = PKInkingTool(.pen, color: .black, width: 15)
//        canvasView.backgroundColor = UIColor.softCream
//        canvasView.delegate = context.coordinator
//        toolPicker.addObserver(canvasView)
//        toolPicker.setVisible(true, forFirstResponder: canvasView)
//        canvasView.becomeFirstResponder()
//        return canvasView
//    }
//    
//    func updateUIView(_ uiView: PKCanvasView, context: Context) {
//        if uiView.drawing != drawing {
//            uiView.drawing = drawing
//        }
//    }
//    
//    func makeCoordinator() -> Coordinator {
//           Coordinator(drawing: $drawing)
//    }
//       
//   class Coordinator: NSObject, PKCanvasViewDelegate {
//       @Binding var drawing: PKDrawing
//       init(drawing: Binding<PKDrawing>) { _drawing = drawing }
//       func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
//           drawing = canvasView.drawing
//       }
//    }
//}

//TODO: Fix timing out issues
// Drawing Canvas wrapper
struct DrawingCanvas: UIViewRepresentable {
    let toolPicker: PKToolPicker
    @Binding var drawing: PKDrawing

    func makeUIView(context: Context) -> PKCanvasView {
        let canvasView = PKCanvasView()
        canvasView.drawingPolicy = .anyInput
        canvasView.tool = PKInkingTool(.pen, color: .black, width: 15)
        canvasView.backgroundColor = UIColor.softCream
        
        canvasView.delegate = context.coordinator
        
        toolPicker.addObserver(canvasView)
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        canvasView.becomeFirstResponder()
        
        canvasView.drawing = drawing
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        if uiView.drawing != drawing {
            uiView.drawing = drawing
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(drawing: $drawing)
    }
    
    class Coordinator: NSObject, PKCanvasViewDelegate {
        @Binding var drawing: PKDrawing
        
        init(drawing: Binding<PKDrawing>) {
            _drawing = drawing
        }
        
        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            drawing = canvasView.drawing
        }
    }
}


#Preview {
    NotePageDrawView()
        .modelContainer(for: NoteModel.self, inMemory: true)
}
