//
//  BaseViewController.swift
//  ExReactorFlow
//
//  Created by KyungSeok Lee on 2020/03/30.
//  Copyright © 2020 KyungSeok Lee. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    lazy private(set) var className: String = {
        return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()

    var disposeBag = DisposeBag()

    deinit {
        log.info("DEINIT: \(self.className)")
    }
}
