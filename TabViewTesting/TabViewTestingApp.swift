//
//  TabViewTestingApp.swift
//  TabViewTesting
//
//  Created by Michael  Roth on 4/27/22.
//

import CoreData
import SwiftUI

@main
struct TabViewTestingApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        let context = PersistenceController.shared.container.viewContext

        // Attempt to fetch the core data object with the key "key"
        let request = NSFetchRequest<Item>(entityName: "Item")
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(Item.key), "key")
        request.sortDescriptors = []

        // If the fetch is empty, create the object so there's one for use in the test app.
        let fetched = (try? context.fetch(request)) ?? []
        if fetched.isEmpty {
            let item = Item(context: context)
            item.key = "key"
            item.value = "hello"
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
