//
//  LoginModel.swift
//  ROUND-STREAK
//
//  Created by jagadeesh on 27/4/2562 BE.
//  Copyright © 2562 jagadeesh. All rights reserved.
//

import Foundation

public struct LoginModel:Codable{
    public let name: String?
    public let email: String?
    public let consecutiveRoundCount:Int?
    public let accessToken: String?
    public init(name: String?, email: String?, consecutiveRoundCount: Int?, accessToken:String?)
    {
        self.name = name
        self.email = email
        self.consecutiveRoundCount = consecutiveRoundCount
        self.accessToken = accessToken
    }
}

extension LoginModel
{
    public init(from jsonData: [String: Any]?) {
        
        name = jsonData?["name"] as? String ?? ""
        email = jsonData?["email"] as? String ?? ""
        consecutiveRoundCount = jsonData?["consecutive_round_count"] as? Int
        accessToken = jsonData?["access_token"] as? String ?? ""
    }
    
}
