//
//  RegisterPresenter.swift
//  ROUND-STREAK
//
//  Created by jagadeesh on 27/4/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

protocol RegisterPresentationLogic {
    func presentAlert(alert : Register.LoginFailure.Responce)
    func updateLoginResponse(response: Register.Login.Response)
}

class RegisterPresenter: RegisterPresentationLogic {
    weak var viewController: RegisterDisplayLogic?
    
    // MARK: Presentation logic
    
    func presentAlert(alert : Register.LoginFailure.Responce)  {
        viewController?.displayAlert(loginFailure: Register.LoginFailure.ViewModel(alertString: alert.alertString))
    }
    
    func updateLoginResponse(response: Register.Login.Response) {
        
        let viewModel = Register.Login.ViewModel(content: response.results)
        viewController?.LoginSuccessWithModel(viewModel: viewModel)
    }
}
