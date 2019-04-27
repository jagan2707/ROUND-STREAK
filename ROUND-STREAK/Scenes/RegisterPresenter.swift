//
//  RegisterPresenter.swift
//  ROUND-STREAK
//
//  Created by jagadeesh on 27/4/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

protocol RegisterPresentationLogic {
    func presentSomething(response: Register.Something.Response)
}

class RegisterPresenter: RegisterPresentationLogic {
    weak var viewController: RegisterDisplayLogic?
    
    // MARK: Presentation logic
    
    func presentSomething(response: Register.Something.Response) {
        let viewModel = Register.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
