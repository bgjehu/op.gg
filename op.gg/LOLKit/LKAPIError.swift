//
//  LKAPIError.swift
//  op.gg
//
//  Created by Jieyi Hu on 10/7/15.
//  Copyright © 2015 fullstackpug. All rights reserved.
//

import UIKit

enum LKAPIError : Int {
    case BadRequest = 400
    case Unauthorized = 401
    case NotFound = 404
    case RateLimitExceeded = 429
    case NoResponse = 444
    case InternalServerError = 500
    case ServiceUnavailable = 503
    case Unknown = 520
    func ToNSError(userInfo : [NSObject : AnyObject]?) -> NSError {
        let domain = "com.fullstackpug.op-gg.RiotAPIError"
        return NSError(domain: domain, code: self.rawValue, userInfo: userInfo)
    }
    func ToNSError() -> NSError {
        let domain = "com.fullstackpug.op-gg.RiotAPIError"
        return NSError(domain: domain, code: self.rawValue, userInfo: nil)
    }
}
