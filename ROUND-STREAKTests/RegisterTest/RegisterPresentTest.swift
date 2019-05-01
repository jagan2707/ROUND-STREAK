//
//  RegisterPresentTest.swift
//  ROUND-STREAKTests
//
//  Created by jagadeesh on 1/5/2562 BE.
//  Copyright © 2562 jagadeesh. All rights reserved.
//

import XCTest
@testable import ROUND_STREAK

class RegisterPresentTest: XCTestCase {

    var registerPresenter = RegisterPresenter()
    override func setUp() {
       super.setUp()
    }

    override func tearDown() {
     super.tearDown()
    }
    
    class RegisterPresenterOutputSpy: RegisterDisplayLogic {
        
        var displayNextScreenCalled = false
        var displayFailureAlertCalled = false
        func displayAlert(loginFailure: Register.LoginFailure) {
            displayFailureAlertCalled = true
        }
        
        func LoginSuccessWithModel(viewModel: Register.Login.ViewModel) {
            displayNextScreenCalled = true
        }
    }

    //MARK: Tests
    func testPresentLoginResponseShouldAskViewControllerToGotoNextScreen() {
        //Given
        let registerPresenterOutputSpy = RegisterPresenterOutputSpy()
        registerPresenter.viewController = registerPresenterOutputSpy
        let response = Register.Login.Response(results: LoginModel(name: nil, email: nil, consecutiveRoundCount: 0, accessToken: ""))
        //When
        registerPresenter.updateLoginResponse(response: response)
        //Then
        XCTAssertTrue(registerPresenterOutputSpy.displayNextScreenCalled)
    }
    
    func testPresentFailureAlertShouldAskViewControllerToDisplayErrorAlert() {
        //Given
        let registerPresenterOutputSpy = RegisterPresenterOutputSpy()
        registerPresenter.viewController = registerPresenterOutputSpy
        //When
        registerPresenter.presentAlert(alert: Register.LoginFailure(alertString: "Something went wrong"))
        //Then
        XCTAssertTrue(registerPresenterOutputSpy.displayFailureAlertCalled)
    }

}
