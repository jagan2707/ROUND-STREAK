//
//  BonusInteractorTest.swift
//  ROUND-STREAKTests
//
//  Created by jagadeesh on 1/5/2562 BE.
//  Copyright © 2562 jagadeesh. All rights reserved.
//

import XCTest
@testable import ROUND_STREAK

class BonusInteractorTest: XCTestCase {

    var bonusInteractor = BonusInteractor()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    class BonusWorkerSpy: BonusWorker {
        var isGetResponse = false
        var isFailure = false
        override func getListOfRoundsWith(request: Bonus.RoundStreak.Request, onSuccess success: @escaping (_ result: [Int]) -> Void, onFailure failure: @escaping (_ roundStreakFailure: Bonus.RoundStreakFailure) -> Void) {
            isGetResponse = true
            if !isFailure {
                success([])
            }
            else {
                failure(Bonus.RoundStreakFailure(alertString: "Something Wrong"))
            }
        }
    }
    
    class BonusInteractorOutputSpy: BonusPresentationLogic {
        var pesentData = false
        var showFailure = false
        func presentRoundStreak(response: Bonus.RoundStreak.Response) {
            pesentData = true
        }
        func presentAlert(alert: Bonus.RoundStreakFailure) {
            showFailure = true
        }
    }
    
    //Test Cases
    func testBonusSuccessShouldAskPresenterToGotoNextScreen() {
        //Given
        let bonusOutSpy = BonusInteractorOutputSpy()
        let bonusWorkerSpy = BonusWorkerSpy()
        bonusWorkerSpy.isFailure = false
        bonusInteractor.presenter = bonusOutSpy
        bonusInteractor.worker = bonusWorkerSpy
        
        //When
        bonusInteractor.getListOfRounds(request: Bonus.RoundStreak.Request(accessToken: ""))
        
        //Then
        XCTAssertTrue(bonusWorkerSpy.isGetResponse)
        XCTAssertTrue(bonusOutSpy.pesentData)
    }
    
    func testBonusFailureShouldAskPresenterToDisplayAlert() {
        
        //Given
        let bonusOutSpy = BonusInteractorOutputSpy()
        let bonusWorkerSpy = BonusWorkerSpy()
        bonusWorkerSpy.isFailure = true
        bonusInteractor.presenter = bonusOutSpy
        bonusInteractor.worker = bonusWorkerSpy
        //When
        bonusInteractor.getListOfRounds(request: Bonus.RoundStreak.Request(accessToken: ""))
        //Then
        XCTAssertTrue(bonusWorkerSpy.isFailure)
        XCTAssertTrue(bonusOutSpy.showFailure)
    }
    
}
