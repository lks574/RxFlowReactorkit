//
//  CounterViewReactor.swift
//  ExReactorFlow
//
//  Created by Moon on 2020/03/31.
//  Copyright © 2020 KyungSeok Lee. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift
import ReactorKit

final class CounterViewReactor: Reactor {
    
    enum Action {
        case incrase
        case decrease
    }
    
    enum Mutation {
        case increaseValue
        case decreaseValue
        case setLoading(Bool)
    }
    
    struct State {
        var value: Int
        var isLoading: Bool
    }
    
    let initialState: State
    
    init() {
        self.initialState = State(value: 0, isLoading: false)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .incrase:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.increaseValue).delay(0.5, scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false))
            ])
            
        case .decrease:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.decreaseValue).delay(0.5, scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false))
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .increaseValue:
            state.value += 1
        case .decreaseValue:
            state.value -= 1
        case let .setLoading(isLoding):
            state.isLoading = isLoding
        }
        return state
    }
    
}
