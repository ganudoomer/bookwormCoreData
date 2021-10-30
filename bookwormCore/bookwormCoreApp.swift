//
//  bookwormCoreApp.swift
//  bookwormCore
//
//  Created by Sree on 31/10/21.
//

import SwiftUI

@main
struct bookwormCoreApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
