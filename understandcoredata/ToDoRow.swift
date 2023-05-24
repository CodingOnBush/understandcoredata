//
//  ToDoRow.swift
//  understandcoredata
//
//  Created by VegaPunk on 24/05/2023.
//

import SwiftUI

struct ToDoRow: View {
    let persistenceManager: PersistenceManager
    let item: ToDoItem
    @State private var isDone = false
    
    var body: some View {
        HStack {
            Text(item.taskDescription ?? "")
                .lineLimit(1)
                .layoutPriority(1)
            Spacer()
            Toggle("", isOn: $isDone)
        }
        .onAppear {
            isDone = item.isCompleted
        }
        .onChange(of: isDone) { newValue in
            if newValue != item.isCompleted {
                item.isCompleted = newValue
                persistenceManager.updateItem(item)
            }
        }
    }
}

struct ToDoRow_Previews: PreviewProvider {
    static let persistenceManager = PersistenceManager(previewMode: true)
    
    static var previews: some View {
        ToDoRow(persistenceManager: persistenceManager, item: persistenceManager.items.first!)
            .padding()
            .previewLayout(.fixed(width: 380, height: 100))
    }
}
