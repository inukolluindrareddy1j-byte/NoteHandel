//
//  AddedingNote.swift
//  NoteHandel
//
//  Created by inukollu indrareddy on 19/03/26.
//
import SwiftUI
import CoreData

struct AddedingNote: View {
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State var editarName: String = ""
    @State var editable: Bool = true
    @State var contain: String = ""
    @State var item: Item?
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading){
                Label("Editar Name", systemImage: "person.crop.circle")
                TextField("Enter Name", text: $editarName).padding(5)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .circular)
                            .stroke(Color.gray, lineWidth: editable ? 1 : 0)
                            .fill(editable ? Color(.systemBackground) : Color.gray.opacity(0.2))
                    }.disabled(!editable)
                TextEditor(text: $contain)
                    .padding(5)
                    .background {
                    RoundedRectangle(cornerRadius: 10, style: .circular)
                        .stroke(Color.gray, lineWidth: 1)
                        .fill(Color.gray.opacity(0.2))
                    }
            }.padding(20)
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        Button {
            handleSave()
            dismiss()
        } label: {
            Text("Save").tint(.white)
        }.padding()
            .background {
                RoundedRectangle(cornerRadius: 10, style: .circular).stroke(Color.blue, lineWidth: 1).fill(Color.blue.opacity(0.2))
            }
            .frame(width: 110, height: 20)
    }

    func handleSave() {
        var itemData : Item = Item(context: context)
        if let item = item {
            itemData = item
        }
        itemData.editBy = editarName
        itemData.body = contain
        itemData.timestamp = Date()
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}

#Preview {
    AddedingNote()
}
