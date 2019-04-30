//
//  RegisterRouter.swift
//  ROUND-STREAK
//
//  Created by jagadeesh on 27/4/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

protocol RegisterRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    func routeToBonusScreen(loginModel: Register.Login.ViewModel.DisplayedData)

}

class RegisterRouter: NSObject, RegisterRoutingLogic {
    weak var viewController: RegisterViewController?
    
    // MARK: Routing
    
    func routeToBonusScreen(loginModel: Register.Login.ViewModel.DisplayedData)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "BonusViewController") as! BonusViewController
        destinationVC.loginRespose = loginModel
        viewController?.present(destinationVC, animated: true, completion: nil)
    }
}
