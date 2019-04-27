//
//  RegisterInteractor.swift
//  ROUND-STREAK
//
//  Created by jagadeesh on 27/4/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

protocol RegisterBusinessLogic {
    func doSomething(request: Register.Something.Request)
}

class RegisterInteractor: RegisterBusinessLogic {
    var presenter: RegisterPresentationLogic?
    fileprivate lazy var worker = RegisterWorker()
    
    // MARK: Business logic
    
    func doSomething(request: Register.Something.Request) {
        worker.doSomeWork()
        
        let response = Register.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
