//
//  RegisterModels.swift
//  ROUND-STREAK
//
//  Created by jagadeesh on 27/4/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

enum Register {
    // MARK: Use cases
    
    enum Login {
        
        struct Request {
            var email: String
            var password: String
        }
        
        struct Response {
            var results : LoginModel
        }
        
        struct ViewModel {
            
            struct DisplayedData
            {
                 let consecutiveRoundCount:Int?
                 let accessToken: String?
            }
            var displayedData: DisplayedData
        }
    }
    struct LoginFailure
    {
      var alertString: String
    }
}
