//
//  BonusPresenterTest.swift
//  ROUND-STREAKTests
//
//  Created by jagadeesh on 1/5/2562 BE.
//  Copyright © 2562 jagadeesh. All rights reserved.
//

import XCTest
@testable import ROUND_STREAK

class BonusPresenterTest: XCTestCase {

    var bonusPresenter = BonusPresenter()
    override func setUp() {
       super.setUp()
    }

    override func tearDown() {
       super.tearDown()
    }

    class BonusPresenterOutputSpy: BonusDisplayLogic {
        var displayData = false
        var displayFailureAlertCalled = false
        
        func displayListOfRoundStreak(viewModel: Bonus.RoundStreak.ViewModel) {
            displayData = true
        }
        func displayAlert(dataFailure: Bonus.RoundStreakFailure) {
            displayFailureAlertCalled = true
        }
    }
    
    //MARK: Tests
    func testPresentLoginResponseShouldAskViewControllerToGotoNextScreen() {
        //Given
        let bonusPresenterOutputSpy = BonusPresenterOutputSpy()
        bonusPresenter.viewController = bonusPresenterOutputSpy
        let response = Bonus.RoundStreak.Response(results: [])
        //When
        self.bonusPresenter.presentRoundStreak(response: response)
        //Then
        XCTAssertTrue(bonusPresenterOutputSpy.displayData)
    }
    
    func testPresentFailureAlertShouldAskViewControllerToDisplayErrorAlert() {
        //Given
        let bonusPresenterOutputSpy = BonusPresenterOutputSpy()
        bonusPresenter.viewController = bonusPresenterOutputSpy
        //When
        bonusPresenter.presentAlert(alert: Bonus.RoundStreakFailure(alertString: ""))
        XCTAssertTrue(bonusPresenterOutputSpy.displayFailureAlertCalled)
    }

}
