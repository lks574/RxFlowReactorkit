//
//  CounterFlow.swift
//  ExReactorFlow
//
//  Created by Moon on 2020/03/31.
//  Copyright © 2020 KyungSeok Lee. All rights reserved.
//

import Foundation
import RxFlow

final class CounterFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private let rootViewController = UINavigationController()
    private let services: AppServices
    
    init(withServices services: AppServices) {
        self.services = services
    }
    
    deinit {
        log.info("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? SampleStep else { return .none }
        switch step {
        case .counterIsRequired:
            return navigateToCounterScreen()
        default:
            return .none
        }
    }
    
    
    private func navigateToCounterScreen() -> FlowContributors {
        let viewController = CounterViewController.instantiate()
        viewController.title = "Counter"
        
        self.rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: OneStepper(withSingleStep: SampleStep.counterIsRequired)))
    }
}
