//
//  RegisterInteractor.swift
//  ROUND-STREAK
//
//  Created by jagadeesh on 27/4/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

protocol RegisterBusinessLogic {
  func loginWithData(request: Register.Login.Request)
}

class RegisterInteractor: RegisterBusinessLogic {
    var presenter: RegisterPresentationLogic?
    fileprivate lazy var worker = RegisterWorker()
    
    // MARK: Validation


    func loginWithData(request: Register.Login.Request) {
        
        if !isValidEmailAddress(emailAddressString: request.email) {
            
            presenter?.presentAlert(alert: Register.LoginFailure(alertString : "Please enter a valid email address."))
            
        } else if !isValidPassword(passwordString: request.password) {
            
            presenter?.presentAlert(alert: Register.LoginFailure(alertString : "Please enter valid password"))
            
        } else {
            
            worker.loginWithData(request: request, onSuccess: { loginModel in
                
                let responce = Register.Login.Response(results: loginModel)
                self.presenter?.updateLoginResponse(response: responce)
            }) { loginFailure in
            
                self.presenter?.presentAlert(alert: Register.LoginFailure(alertString : loginFailure?.alertString ?? "Please enter valid email and password"))
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
