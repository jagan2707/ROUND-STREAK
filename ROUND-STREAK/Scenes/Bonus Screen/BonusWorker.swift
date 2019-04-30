//
//  BonusWorker.swift
//  ROUND-STREAK
//
//  Created by jagadeesh on 28/4/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

class BonusWorker {
    func getListOfRoundsWith(request: Bonus.RoundStreak.Request, onSuccess success: @escaping (_ result: [Int]) -> Void, onFailure failure: @escaping (_ roundStreakFailure: Bonus.RoundStreakFailure) -> Void) {
        let urlString = "https://api.panya.me/v2/test/streak-bonus"
        guard let url = URL(string: urlString) else {
            return
        }
        let accessToken = request.accessToken
        var request = URLRequest(url: url)
        request.setValue(accessToken, forHTTPHeaderField:"access-token")
        request.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { data, response, error in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    failure(Bonus.RoundStreakFailure(alertString: "Data not found"))
                    return
            }
            do {
                let responseJSON = try? JSONSerialization.jsonObject(with: dataResponse, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    
                    if let dataArray = responseJSON["data"] as? [String: Any]   {
                        if let responseArray = dataArray["streak_bonus"] {
                            success(responseArray as! [Int])
                        }
                    }
                    else {
                        var alertMessage = "Data not found"
                        if responseJSON["error"] != nil {
                            let errorDict = responseJSON["error"] as? [String: Any]
                            if let message = errorDict?["message"] {
                                alertMessage = message as! String
                            }
                        }
                        failure(Bonus.RoundStreakFailure(alertString: alertMessage))
                    }
                }
            }
        }
        task.resume()
    }
    
}
