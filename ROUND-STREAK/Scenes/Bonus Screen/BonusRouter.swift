//
//  BonusRouter.swift
//  ROUND-STREAK
//
//  Created by jagadeesh on 28/4/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

protocol BonusRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    func getBackToLogin()
}

class BonusRouter: NSObject, BonusRoutingLogic {
    weak var viewController: BonusViewController?
    
    // MARK: Routing
    func getBackToLogin() {
        self.viewController?.dismiss(animated: true, completion: nil)
    }
}
