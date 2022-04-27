//
//  TextViewModel.swift
//  TabViewTesting
//
//  Created by Michael  Roth on 4/27/22.
//

import Combine
import CoreData

class TextViewModel: ObservableObject {

    @Published var textValue: String {
        didSet {
            // Check that the new value is not the same as the current item.value or else an infinte loop is created.
            if item.value != textValue {
                item.value = textValue
                try! context.save()
            }
        }
    }

    private(set) var item: Item
    private(set) var title: String

    private var subscriber: AnyCancellable?

    private var context: NSManagedObjectContext

    init(title: String, context: NSManagedObjectContext) {

        self.title = title
        self.context = context

        let request = NSFetchRequest<Item>(entityName: "Item")
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(Item.key), "key")
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Item.value), ascending: true)]

        let fetched = try! context.fetch(request)
        let fetchedItem = fetched.first!
        self.textValue = fetchedItem.value!
        self.item = fetchedItem

        // Create a publisher to update the text value whenever the value is updated.
        self.subscriber = fetchedItem.publisher(for: \.value)
            .sink(receiveValue: {
                if let newValue = $0 {
                    self.textValue = newValue
                }
            })
    }
}
