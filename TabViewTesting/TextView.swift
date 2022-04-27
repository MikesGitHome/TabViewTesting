//
//  TextView.swift
//  TabViewTesting
//
//  Created by Michael  Roth on 4/27/22.
//

import Combine
import SwiftUI

struct TextView: View {

    @ObservedObject private var viewModel: TextViewModel

    @State private var text: String

    private var relay = PassthroughSubject<String, Never>()
    private var debouncedPublisher: AnyPublisher<String, Never>

    init(viewModel: TextViewModel) {
        self.viewModel = viewModel

        self._text = State(initialValue: viewModel.textValue)

        self.debouncedPublisher = relay
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    var body: some View {
        LazyVStack {
            Text(viewModel.title)
                .font(.title)
            TextField("write something", text: $text)
                .onChange(of: text) {
                    relay.send($0)
                }
        }
        .padding()
        .onReceive(debouncedPublisher) {
            viewModel.textValue = $0
        }
        .onAppear {
            self.text = viewModel.textValue
        }
    }
    
}
