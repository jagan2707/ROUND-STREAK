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
        
        struct LoginDetails
        {
            var email: String
            var password: String
        }
        struct Request {
            let url = "https://api.panya.me/v2/test/login"
        }
        
        struct Response {
        }
        
        struct ViewModel {
        }
    }
    enum LoginFailure
    {
        struct Responce {
            var alertString: String
        }
        struct ViewModel {
            var alertString: String
        }
    }
}
