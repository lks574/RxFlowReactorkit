//
//  GitHubSearchFlow.swift
//  ExReactorFlow
//
//  Created by Moon on 2020/03/31.
//  Copyright © 2020 KyungSeok Lee. All rights reserved.
//

import UIKit

final class GitHubSearchFlow: Flow {
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
        case .gitHubSearchIsRequired:
            return navigateToGitHubSearchScreen()
        default:
            return .none
        }
    }
    
    private func navigateToGitHubSearchScreen() -> FlowContributors {
        let viewController = GitHubSearchViewController.instantiate()
        viewController.title = "GitHubSearch"
        self.rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: OneStepper(withSingleStep: SampleStep.gitHubSearchIsRequired)))
    }
}
