//
//  CounterFeature.swift
//  LearnTCA
//
//  Created by Muhammad Rezky on 24/11/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct CounterFeature {
    @ObservableState
    struct State {
        var count = 0
        var fact: String?
        var isLoading: Bool = false
    }
    
    enum Action {
        case incrementButtonTapped
        case decrementButtonTapped
        case factButtonTapped
        case factResponse(String)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .decrementButtonTapped:
                state.fact = nil
                state.count -= 1
                return .none
            case .incrementButtonTapped:
                state.fact = nil
                state.count += 1
                return .none
            case .factButtonTapped:
                state.fact = nil
                state.isLoading = true
                
                return .run { [count = state.count] send in
                    let (data, _) = try await URLSession.shared
                        .data(from: URL(string: "http://numbersapi.com/\(count)")!)
                    let fact = String(decoding: data, as: UTF8.self)
                    await send(.factResponse(fact))
                }
            case .factResponse(let response):
                state.fact = response
                state.isLoading = false
                return .none
            }
        }
    }
}
