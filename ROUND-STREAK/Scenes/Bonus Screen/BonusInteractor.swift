//
//  BonusInteractor.swift
//  ROUND-STREAK
//
//  Created by jagadeesh on 28/4/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

protocol BonusBusinessLogic {
    func getListOfRounds(request: Bonus.RoundStreak.Request.Url, header: Bonus.RoundStreak.Request.Header)
}

class BonusInteractor: BonusBusinessLogic {
    var presenter: BonusPresentationLogic?
    fileprivate lazy var worker = BonusWorker()
    
    // MARK: Business logic
    
    func getListOfRounds(request: Bonus.RoundStreak.Request.Url, header: Bonus.RoundStreak.Request.Header) {
       
        worker.getListOfRoundsWith(request: request, header: header, onSuccess: { (listOfRounds) in
            let response = Bonus.RoundStreak.Response(results: listOfRounds)
            self.presenter?.presentRoundStreak(response: response)
            
        }) { (error) in
            
            self.presenter?.presentAlert(alert: Bonus.RoundStreakFailure(alertString: "Something wrong. Please try again"))
        }
    
    }
}
