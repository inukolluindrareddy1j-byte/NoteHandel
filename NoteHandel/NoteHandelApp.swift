//
//  NoteHandelApp.swift
//  NoteHandel
//
//  Created by inukollu indrareddy on 19/03/26.
//

import SwiftUI
import CoreData

@main
struct NoteHandelApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
