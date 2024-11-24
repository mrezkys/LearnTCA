//
//  LearnTCAApp.swift
//  LearnTCA
//
//  Created by Muhammad Rezky on 24/11/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct LearnTCAApp: App {
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }
    var body: some Scene {
        WindowGroup {
            CounterView(store: LearnTCAApp.store)
        }
    }
}
