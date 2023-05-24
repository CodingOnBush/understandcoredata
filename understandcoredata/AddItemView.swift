//
//  AddItemView.swift
//  understandcoredata
//
//  Created by VegaPunk on 24/05/2023.
//

import SwiftUI

struct AddItemView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var persistenceManager: PersistenceManager
    @State var itemDescription: String = ""
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 80, height: 8)
                .cornerRadius(4)
                .opacity(0.5)
                .padding()
            
            Text("Add Item").font(.title2)
                .padding()
            
            TextField("Add Description", text: $itemDescription)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Spacer()
            
            Button("Save Item") {
                // TODO: ... to be coded...
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .background(.gray.opacity(0.2))
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
