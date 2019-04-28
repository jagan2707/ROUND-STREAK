//
//  Error.swift
//  ROUND-STREAK
//
//  Created by jagadeesh on 27/4/2562 BE.
//  Copyright © 2562 jagadeesh. All rights reserved.
//

import Foundation

public enum ReturnError: Error {
    case apiError(errorCode: String, headerText: String?, errorMessage: String?)
    case invalidJson
}
