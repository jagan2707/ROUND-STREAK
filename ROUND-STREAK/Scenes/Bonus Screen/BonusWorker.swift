//
//  BonusWorker.swift
//  ROUND-STREAK
//
//  Created by jagadeesh on 28/4/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

class BonusWorker {
    
    func getListOfRoundsWith(request: Bonus.RoundStreak.Request.Url,header:Bonus.RoundStreak.Request.Header,   onSuccess success: @escaping (_ result: [Int]) -> Void, onFailure failure: @escaping (_ error: Error?) -> Void) {
        
        let url = URL(string: request.url)!
        var request = URLRequest(url: url)
        request.setValue(header.accessToken, forHTTPHeaderField:"access-token")
        request.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { data, response, error in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    failure(error)
                    return
                    
            }
            do {
                let responseJSON = try? JSONSerialization.jsonObject(with: dataResponse, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    
                    if responseJSON["error"] != nil {
                        failure(ReturnError.invalidJson)
                        return
                    }
                    
                    if let dataArray = responseJSON["data"] as? [String: Any]   {
                        
                        if let responseArray = dataArray["streak_bonus"] {
                            success(responseArray as! [Int])
                        }
                    }
                    else {
                        failure(ReturnError.invalidJson)
                    }
                }
            }
        }
        task.resume()
        
    }
    
}
