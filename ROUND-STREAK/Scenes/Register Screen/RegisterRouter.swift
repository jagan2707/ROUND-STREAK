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
    func routeToBonusScreen(loginModel: LoginModel)

}

class RegisterRouter: NSObject, RegisterRoutingLogic {
    weak var viewController: RegisterViewController?
    
    // MARK: Routing
    
    func routeToBonusScreen(loginModel: LoginModel)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "BonusViewController") as! BonusViewController
        destinationVC.loginRespose = loginModel
        viewController?.present(destinationVC, animated: true, completion: nil)
    }
    
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}
}
