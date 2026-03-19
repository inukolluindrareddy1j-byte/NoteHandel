//
//  Persistence.swift
//  NoteHandel
//
//  Created by inukollu indrareddy on 19/03/26.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container = NSPersistentContainer(name: "NoteHandel")
    
    init () {
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
