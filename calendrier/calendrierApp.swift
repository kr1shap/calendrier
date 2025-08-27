//
//  calendrierApp.swift
//  calendrier
//
//  Created by Krisha Patel on 2025-08-25.
//

import SwiftUI
import SwiftData

@main
struct calendrierApp: App {
    var body: some Scene {
        WindowGroup {
            LandingPageView()
                .modelContainer(for: [NoteModel.self])
        }
    }
}
