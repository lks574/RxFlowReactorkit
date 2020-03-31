//
//  AppFlow.swift
//  ExReactorFlow
//
//  Created by KyungSeok Lee on 2020/03/30.
//  Copyright © 2020 KyungSeok Lee. All rights reserved.
//

import Foundation
import RxFlow

final class AppFlow: Flow {
    var root: Presentable {
        return self.rootWindow
    }
    
    private let rootWindow: UIWindow
    private let services: AppServices
    
    init(withWindow window: UIWindow, andServices services: AppServices) {
        self.rootWindow = window
        self.services = services
    }
    
    deinit {
        log.info("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? SampleStep else { return FlowContributors.none }
        switch step {
        case .onboardingIsRequired:
            return navigationToOnboardingScreen()
        case .onboardingIsComplete, .dashboardIsRequired:
            return navigationToDashboardScreen()
        default:
            return .none
        }
    }
    
    private func navigationToOnboardingScreen() -> FlowContributors {
        if let rootViewController = self.rootWindow.rootViewController {
            rootViewController.dismiss(animated: false, completion: nil)
        }
        let onboardingFlow = OnboardingFlow(withServices: self.services)
        Flows.whenReady(flow1: onboardingFlow) { [unowned self] (root) in
            self.rootWindow.rootViewController = root
        }
        
        return .one(flowContributor: FlowContributor.contribute(withNextPresentable: onboardingFlow, withNextStepper: OneStepper(withSingleStep: SampleStep.introIsRequired)))
    }
    
    
    private func navigationToDashboardScreen() -> FlowContributors {
        let dashboardFlow = DashboardFlow(withServices: self.services)
        Flows.whenReady(flow1: dashboardFlow) { [unowned self] (root) in
            self.rootWindow.rootViewController = root
        }
        return .one(flowContributor: .contribute(withNextPresentable: dashboardFlow, withNextStepper: OneStepper(withSingleStep: SampleStep.dashboardIsRequired)))
    }
    
    
}
