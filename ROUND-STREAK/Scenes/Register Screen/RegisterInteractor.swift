//
//  RegisterInteractor.swift
//  ROUND-STREAK
//
//  Created by jagadeesh on 27/4/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

protocol RegisterBusinessLogic {
  func loginWithData(request: Register.Login.Request, loginData: Register.Login.LoginDetails)
}

class RegisterInteractor: RegisterBusinessLogic {
    var presenter: RegisterPresentationLogic?
    fileprivate lazy var worker = RegisterWorker()
    
    // MARK: Validation


    func loginWithData(request: Register.Login.Request, loginData: Register.Login.LoginDetails) {
        
        if !isValidEmailAddress(emailAddressString: loginData.email) {
            
            presenter?.presentAlert(alert: Register.LoginFailure.Responce(alertString : "Please enter a valid email address."))
            
        } else if !isValidPassword(passwordString: loginData.password) {
            
            presenter?.presentAlert(alert: Register.LoginFailure.Responce(alertString : "Please enter valid password"))
            
        } else {
            
            worker.loginWithData(request: request, body: loginData, onSuccess: { (loginModel) in
                
                let responce = Register.Login.Response(results: loginModel)
                self.presenter?.updateLoginResponse(response: responce)
            }) { (error) in
            
                self.presenter?.presentAlert(alert: Register.LoginFailure.Responce(alertString : "Login Faild"))
            }
        }
    }
    
   private func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
   private func isValidPassword(passwordString: String) -> Bool {
        
        if passwordString.count > 2 {
            return true
        } else {
            return false
        }
    }
}
