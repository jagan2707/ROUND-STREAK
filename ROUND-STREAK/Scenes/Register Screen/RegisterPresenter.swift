//
//  RegisterPresenter.swift
//  ROUND-STREAK
//
//  Created by jagadeesh on 27/4/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

protocol RegisterPresentationLogic {
    func presentAlert(alert : Register.LoginFailure)
    func updateLoginResponse(response: Register.Login.Response)
}

class RegisterPresenter: RegisterPresentationLogic {
    weak var viewController: RegisterDisplayLogic?
    
    // MARK: Presentation logic
    
    func presentAlert(alert : Register.LoginFailure)  {
        viewController?.displayAlert(loginFailure: Register.LoginFailure(alertString: alert.alertString))
    }
    
    func updateLoginResponse(response: Register.Login.Response) {
        
        let viewModel = Register.Login.ViewModel(content: response.results)
        viewController?.LoginSuccessWithModel(viewModel: viewModel)
    }
}
