//
//  RegisterWorker.swift
//  ROUND-STREAK
//
//  Created by jagadeesh on 27/4/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

class RegisterWorker {
  
    //MARK: Get Mobile List
    func loginWithData(request: Register.Login.Request,body:Register.Login.LoginDetails,   onSuccess success: @escaping (_ result: LoginModel) -> Void, onFailure failure: @escaping (_ error: Error?) -> Void) {
        
        let url = URL(string: request.url)!
       
        let json: [String: Any] = ["email": body.email,
                                   "password": body.password]
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
                    failure(ReturnError.invalidJson)
                    return
                }
                
                if let responseDic = responseJSON["data"] as? [String: Any]   {
                let loginModel = LoginModel(from: responseDic)
                success(loginModel)
                }
            }
            } catch let error as NSError {
                failure(error)
            }
        }
    task.resume()
}
   
    
}
