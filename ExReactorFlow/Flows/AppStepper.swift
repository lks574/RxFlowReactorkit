//
//  AppStepper.swift
//  ExReactorFlow
//
//  Created by KyungSeok Lee on 2020/03/30.
//  Copyright © 2020 KyungSeok Lee. All rights reserved.
//

import RxFlow
import RxSwift
import RxCocoa

class AppStepper: Stepper {
    let steps = PublishRelay<Step>()
    private let appServices: AppServices
    private let disposeBag = DisposeBag()
    
    init(withServices services: AppServices){
        self.appServices = services
    }
    
    var initialStep: Step {
        return SampleStep.onboardingIsRequired
    }
    
    
    func readyToEmitSteps() {
        self.appServices
            .preferencesService.rx
            .isOnboarded
            .debug()
            .map {$0 ? SampleStep.onboardingIsComplete : SampleStep.onboardingIsRequired}
            .debug()
            .bind(to: self.steps)
            .disposed(by: self.disposeBag)
    }
}
