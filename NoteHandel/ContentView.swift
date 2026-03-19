//
//  ContentView.swift
//  NoteHandel
//
//  Created by inukollu indrareddy on 19/03/26.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)], animation: .bouncy)
    private var items: FetchedResults<Item>
    @State private var itemToDelete: Item?

    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        AddedingNote(editarName: item.editBy ?? "", editable: false, contain: item.body ?? "", item: item)
                    } label: {
                        Text(item.editBy ?? "No Title")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .alert(item: $itemToDelete) { item in
                Alert(
                    title: Text("Confirm Delete"),
                    message: Text("Delete this item?"),
                    primaryButton: .destructive(Text("Delete")) {
                       deleteItems(items: item)
                    },
                    secondaryButton: .cancel()
                )
            }
            .navigationTitle(Text("NoteHandel"))
            .toolbar {
                ToolbarItem {
                    EditButton()
                }
                ToolbarItem {
                    NavigationLink {
                        AddedingNote(editable: true)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }

    func deleteItems(offsets: IndexSet) {
        if let index = offsets.first {
            self.itemToDelete = items[index]
        }
    }

    func deleteItems(items: Item) {
        withAnimation {
            viewContext.delete(items)
            do {
                try viewContext.save()
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    ContentView()
}
