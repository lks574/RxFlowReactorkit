//
//  OnboardingIntroViewReactor.swift
//  ExReactorFlow
//
//  Created by KyungSeok Lee on 2020/03/30.
//  Copyright © 2020 KyungSeok Lee. All rights reserved.
//

import Foundation
import ReactorKit
import RxFlow
import RxSwift

final class OnboardingIntroViewReactor: Reactor, HasPreferencesService {
    let preferencesService = PreferencesService()
    
    enum Action {
        case introIsComplete
    }
    
    enum Mutation {
        case moveDashboard
    }
    
    struct State {
        var step: Step = SampleStep.introIsRequired
    }
    
    let initialState = State()
    
    func mutate(action: OnboardingIntroViewReactor.Action) -> Observable<OnboardingIntroViewReactor.Mutation> {
        switch action {
        case .introIsComplete:
            preferencesService.setOnboarded()
            return Observable.just(Mutation.moveDashboard)
        }
    }
    
    func reduce(state: OnboardingIntroViewReactor.State, mutation: OnboardingIntroViewReactor.Mutation) -> OnboardingIntroViewReactor.State {
        var state = state
        switch mutation {
        case .moveDashboard:
            state.step = SampleStep.introIsComplete
            return state
        }
    }
}
