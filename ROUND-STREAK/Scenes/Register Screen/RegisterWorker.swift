//
//  RegisterWorker.swift
//  ROUND-STREAK
//
//  Created by jagadeesh on 27/4/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

class RegisterWorker {
  
    //MARK: Login Api
    func loginWithData(request: Register.Login.Request, onSuccess success: @escaping (_ result: LoginModel) -> Void, onFailure failure: @escaping (_ loginFailure: Register.LoginFailure?) -> Void) {
        
        let url = URL(string: request.url)!
       
        let json: [String: Any] = ["email": request.email,
                                   "password": request.password]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            do {
            guard let data = data, error == nil else {
               throw ReturnError.invalidJson
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                
                if responseJSON["error"] != nil {
                    
                    let errorDict = responseJSON["error"] as? [String: Any]
                    let errorMessage = errorDict?["message"] ?? "Please enter valid email and password"
                    let loginFailure = Register.LoginFailure(alertString: errorMessage as! String)
                    failure(loginFailure)
                    return
                }
                else if let responseDic = responseJSON["data"] as? [String: Any]   {
                    
                let loginModel = LoginModel(from: responseDic)
                success(loginModel)
                } else {
                    throw ReturnError.invalidJson
                }
            }
            } catch _ as NSError {
                
                let errorMessage = "Something went wrong!!. Please try again"
                let loginFailure = Register.LoginFailure(alertString: errorMessage )
                failure(loginFailure)
            }
        }
    task.resume()
}
   
}
