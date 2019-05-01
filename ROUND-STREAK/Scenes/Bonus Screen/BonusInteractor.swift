//
//  BonusInteractor.swift
//  ROUND-STREAK
//
//  Created by jagadeesh on 28/4/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

protocol BonusBusinessLogic {
    func getListOfRounds(request: Bonus.RoundStreak.Request)
}

class BonusInteractor: BonusBusinessLogic {
    var presenter: BonusPresentationLogic?
    lazy var worker = BonusWorker()
    
    // MARK: Business logic
    
    func getListOfRounds(request: Bonus.RoundStreak.Request) {
       
        worker.getListOfRoundsWith(request: request, onSuccess: { (listOfRounds) in
            let response = Bonus.RoundStreak.Response(results: listOfRounds)
            self.presenter?.presentRoundStreak(response: response)
            
        }) { (roundStreakFailure) in
            
            self.presenter?.presentAlert(alert: Bonus.RoundStreakFailure(alertString: roundStreakFailure.alertString))
        }
    
    }
}
