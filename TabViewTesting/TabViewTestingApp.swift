//
//  TabViewTestingApp.swift
//  TabViewTesting
//
//  Created by Michael  Roth on 4/27/22.
//

import SwiftUI

@main
struct TabViewTestingApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
