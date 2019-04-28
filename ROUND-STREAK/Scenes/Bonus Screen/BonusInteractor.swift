//
//  BonusInteractor.swift
//  ROUND-STREAK
//
//  Created by jagadeesh on 28/4/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

protocol BonusBusinessLogic {
    func doSomething(request: Bonus.Something.Request)
}

class BonusInteractor: BonusBusinessLogic {
    var presenter: BonusPresentationLogic?
    fileprivate lazy var worker = BonusWorker()
    
    // MARK: Business logic
    
    func doSomething(request: Bonus.Something.Request) {
        worker.doSomeWork()
        
        let response = Bonus.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
