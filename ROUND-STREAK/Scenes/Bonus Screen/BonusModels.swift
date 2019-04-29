//
//  BonusModels.swift
//  ROUND-STREAK
//
//  Created by jagadeesh on 28/4/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

enum Bonus {
    // MARK: Use cases
    
    enum RoundStreak {
        
        struct Request {

            struct Url {
                let url = "https://api.panya.me/v2/test/streak-bonus"
            }
            struct Header {
                var accessToken: String
            }
        }
        struct Response {
            var results : [Int]
        }
        
        struct ViewModel {
            var content: [Int]
        }
    }
    
    struct RoundStreakFailure
    {
        var alertString: String
    }
}