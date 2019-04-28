//
//  BonusPresenter.swift
//  ROUND-STREAK
//
//  Created by jagadeesh on 28/4/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

protocol BonusPresentationLogic {
    func presentSomething(response: Bonus.Something.Response)
}

class BonusPresenter: BonusPresentationLogic {
    weak var viewController: BonusDisplayLogic?
    
    // MARK: Presentation logic
    
    func presentSomething(response: Bonus.Something.Response) {
        let viewModel = Bonus.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
