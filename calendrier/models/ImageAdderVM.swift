//
//  ImageAdderVM.swift
//  calendrier
//
//  Created by Krisha Patel on 2025-08-26.
//
//MARK: IGNORE
//MARK: FUTURE IMPLEMENTATION
import SwiftUI
import PhotosUI

@MainActor
class ImageAdderVM: ObservableObject {
    @Published var selectedItems: [PhotosPickerItem] = []
    @Published var selectedImages: [UIImage] = []
    @Published var isError: Bool = false
    
    func loadImages() async {
        var newImages: [UIImage] = []
        var errors: [String] = []
        
        for (index, item) in selectedItems.enumerated() {
            do {
                guard let data = try await item.loadTransferable(type: Data.self) else {
                    isError = true
                    break
                }
                
                guard let uiImage = UIImage(data: data) else {
                    errors.append("Item \(index + 1): Could not convert data to UIImage")
                    isError = true
                    break
                }
                
                newImages.append(uiImage)
            } catch {
            }
        }
        
        selectedImages = newImages
    }
}
