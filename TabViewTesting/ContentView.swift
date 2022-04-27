//
//  ContentView.swift
//  TabViewTesting
//
//  Created by Michael  Roth on 4/27/22.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @Environment(\.managedObjectContext) private var viewContext
    @State private var selectedIndex: Int = 0

    var tabTitles: Array<String> = ["Tab 1", "Tab 2", "Tab 3", "Tab 4"]

    var body: some View {
        // Create a page style tab view from the tab titles.
        TabView(selection: $selectedIndex) {

            ForEach(tabTitles.indices, id: \.self) { index in
                TextView(viewModel: TextViewModel(
                    title: tabTitles[index],
                    context: viewContext))
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}
