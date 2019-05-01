//
//  RegisterInteractorTest.swift
//  ROUND-STREAKTests
//
//  Created by jagadeesh on 1/5/2562 BE.
//  Copyright © 2562 jagadeesh. All rights reserved.
//

import XCTest
@testable import ROUND_STREAK

class RegisterInteractorTest: XCTestCase {

    var registerInteractor = RegisterInteractor()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    class RegisterWorkerSpy: RegisterWorker {
        
        var isLoginSuccess = false
        var isFailure = false
        override func loginWithData(request: Register.Login.Request, onSuccess success: @escaping (_ result: LoginModel) -> Void, onFailure failure: @escaping (_ loginFailure: Register.LoginFailure?) -> Void) {
            isLoginSuccess = true
            let loginModel = LoginModel(from: nil)
            
            if !isFailure {
                success(loginModel)
            }
            else {
                failure(Register.LoginFailure(alertString: "Login Failed" ))
            }
        }
    }

    class RegisterInteractorOutputSpy: RegisterPresentationLogic {
       
        
        var presentNextScreen = false
        var showFailure = false
        
        func presentAlert(alert: Register.LoginFailure) {
            showFailure = true
        }
        
        func updateLoginResponse(response: Register.Login.Response) {
            presentNextScreen = true
        }
        
    }

    //Test Cases
    func testRegisterSuccessShouldAskPresenterToGotoNextScreen() {
        //Given
        let registerOutSpy = RegisterInteractorOutputSpy()
        let registerWorkerSpy = RegisterWorkerSpy()
        registerWorkerSpy.isFailure = false
        registerInteractor.presenter = registerOutSpy
        registerInteractor.worker = registerWorkerSpy
        let request = Register.Login.Request(email: "candidate@panya.me", password: "becoolatpanya")
        //When
       registerInteractor.loginWithData(request: request)
        
        //Then
        XCTAssertTrue(registerWorkerSpy.isLoginSuccess)
        XCTAssertTrue(registerOutSpy.presentNextScreen)
    }
    
    func testRegisterFailureShouldAskPresenterToDisplayAlert() {
        
        //Given
        let registerOutSpy = RegisterInteractorOutputSpy()
        let registerWorkerSpy = RegisterWorkerSpy()
        registerWorkerSpy.isFailure = true
        registerInteractor.presenter = registerOutSpy
        registerInteractor.worker = registerWorkerSpy
        let request = Register.Login.Request(email: "candidate@panya.me", password: "becoola")
        
        //When
        registerInteractor.loginWithData(request: request)
        
        //Then
        XCTAssertTrue(registerWorkerSpy.isFailure)
        XCTAssertTrue(registerOutSpy.showFailure)
    }
    
    
    
}
