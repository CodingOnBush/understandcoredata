//
//  understandcoredataApp.swift
//  understandcoredata
//
//  Created by VegaPunk on 24/05/2023.
//

import SwiftUI

@main
struct understandcoredataApp: App {
    @StateObject var persistenceManager = PersistenceManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(persistenceManager)
        }
    }
}
