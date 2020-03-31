//
//  SampleStep.swift
//  ExReactorFlow
//
//  Created by KyungSeok Lee on 2020/03/30.
//  Copyright © 2020 KyungSeok Lee. All rights reserved.
//
import RxFlow


enum SampleStep: Step {
    case onboardingIsRequired
    case onboardingIsComplete

    case introIsRequired
    case introIsComplete

    case dashboardIsRequired

    case counterIsRequired

    case gitHubSearchIsRequired

    case settingIsRequired

}

