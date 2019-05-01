//
//  BonusPresenter.swift
//  ROUND-STREAK
//
//  Created by jagadeesh on 28/4/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

protocol BonusPresentationLogic {
    func presentRoundStreak(response: Bonus.RoundStreak.Response)
    func presentAlert(alert : Bonus.RoundStreakFailure)
}

class BonusPresenter: BonusPresentationLogic {
    weak var viewController: BonusDisplayLogic?

    // MARK: Presentation logic
     func presentRoundStreak(response: Bonus.RoundStreak.Response) {
        let viewModel = Bonus.RoundStreak.ViewModel(content: response.results)
        viewController?.displayListOfRoundStreak(viewModel: viewModel)
    }
    
    func presentAlert(alert : Bonus.RoundStreakFailure)  {
        viewController?.displayAlert(dataFailure: alert)
    }
}
