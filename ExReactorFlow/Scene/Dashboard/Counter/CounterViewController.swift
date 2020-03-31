//
//  CounterViewController.swift
//  ExReactorFlow
//
//  Created by Moon on 2020/03/31.
//  Copyright © 2020 KyungSeok Lee. All rights reserved.
//

import UIKit
import Reusable
import SafariServices

class CounterViewController: BaseViewController, StoryboardBased ,StoryboardView {

    
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var linkButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.reactor = CounterViewReactor()
    }
    
    func bind(reactor: CounterViewReactor) {
        bindView(reactor)
        bindAction(reactor)
        bindState(reactor)
    }
}

private extension CounterViewController {
    func bindView(_ reactor: CounterViewReactor){
        linkButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                guard let url = URL(string: "https://github.com/ReactorKit/ReactorKit/blob/master/Examples/Counter/README.md") else { return }
                let viewController = SFSafariViewController(url: url)
                self.present(viewController, animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
    
    func bindAction(_ reactor: CounterViewReactor){
        increaseButton.rx.tap
            .map { Reactor.Action.incrase }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        decreaseButton.rx.tap
            .map { Reactor.Action.decrease }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    func bindState(_ reactor: CounterViewReactor){
        reactor.state.map{ $0.value }       // 10
            .distinctUntilChanged()         // 다른 원소인 경우만 발생
            .map { "\($0)" }                // "10"
            .bind(to: valueLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map{$0.isLoading}
            .distinctUntilChanged()
            .bind(to: activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
    }
}
