//
//  ToDoView.swift
//  understandcoredata
//
//  Created by VegaPunk on 24/05/2023.
//

import SwiftUI

struct ToDoView: View {
    
    @EnvironmentObject var persistenceManager: PersistenceManager
    @State private var showingSheet = false
    @State private var showNotCompleted = false
    @State private var sortedAlphabetically = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
                List {
                    toggleArea
                    ForEach(persistenceManager.items) { item in
                        ToDoRow(persistenceManager: persistenceManager, item: item)
                    }
                    .onDelete(perform: delete)
                    emptySpacer
                }
                .listStyle(.plain)
                .sheet(isPresented: $showingSheet) {
                    AddItemView()
                }
            }
            .overlay {
                addItemButton
            }
            .onChange(of: showNotCompleted, perform: { newValue in
                persistenceManager.showNotCompleted = newValue
            })
            .onChange(of: sortedAlphabetically, perform: { newValue in
                persistenceManager.sortedAlphabetically = newValue
            })
            .animation(.default, value: persistenceManager.items)
            .navigationTitle("Core Data Demo")
        }
    }
    
    // Selections
    var toggleArea: some View {
        HStack {
            Toggle("Not Completed", isOn: $showNotCompleted)
            
            Toggle("A -> Z", isOn: $sortedAlphabetically)
                .padding(.leading)
        }
        .tint(.cyan)
        .font(.caption)
    }
    
    // Spacer under the floating button
    var emptySpacer: some View {
        Rectangle().frame(height: 80).foregroundColor(.clear)
            .listRowSeparator(.hidden)
    }
    
    // + rounded button
    var addItemButton: some View {
        Button {
            showingSheet.toggle()
        } label: {
            Circle().frame(width: 70, height: 70)
                .overlay {
                    Image(systemName: "plus")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
        }
        .shadow(radius: 5, y: 5)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        .padding()
    }
    
    func delete(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        let itm = persistenceManager.items[index]
        persistenceManager.deleteItem(itm)
    }
}

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView().environmentObject(PersistenceManager(previewMode: true))
    }
}
