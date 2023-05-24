//
//  PersistenceManager.swift
//  understandcoredata
//
//  Created by VegaPunk on 24/05/2023.
//

import Foundation
import CoreData

class PersistenceManager: ObservableObject {
    
    private let persistentContainer: NSPersistentContainer
    lazy var moc = persistentContainer.viewContext
    @Published var items: [ToDoItem] = []
    
    init(previewMode: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "ToDo")
        
        if previewMode {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(
                fileURLWithPath: "/dev/null"
            )
        }

        persistentContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("Persistent Container loaded with error: \(error.localizedDescription)")
            }
        }
        
        if previewMode {
            addMockData()
        }
    }
}

extension PersistenceManager {
    
    func fetchAllToDoItems() {
        let fetchRequest: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
        do {
            items = try moc.fetch(fetchRequest)
        } catch {
            print("Error fetching from Core Data: \(error.localizedDescription)")
        }
    }
}

private extension PersistenceManager {
    
    func save(description: String) {
        do {
            try moc.save()
            fetchAllToDoItems()
            print(description)
        } catch {
            print("Error saving Core Data: \(error.localizedDescription)")
            moc.rollback()
            // the rollback is a very important function to call in case of errors. This function will erase everything that is work in progress on the context wiping it clean. If we do not add it, the object that generated the error will be kept alive in the context and the system will try to save it everytime we call the save function, generating the same error and aborting the whole saving process. Better lose an object than compromise the whole app!
        }
    }
}


extension PersistenceManager {

    private func addMockData() {
        let itm01 = ToDoItem(context: moc)
        itm01.taskDescription = "Paint the ceiling"
        itm01.isCompleted = true
                
        let itm02 = ToDoItem(context: moc)
        itm02.taskDescription = "Have breakfast"
        itm02.isCompleted = true
                
        let itm03 = ToDoItem(context: moc)
        itm03.taskDescription = "Write an article for Medium"
        itm03.isCompleted = false
        
        save(description: "Saved for mock")
    }
}
