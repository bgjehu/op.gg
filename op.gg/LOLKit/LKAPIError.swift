//
//  LKAPIError.swift
//  op.gg
//
//  Created by Jieyi Hu on 10/7/15.
//  Copyright © 2015 fullstackpug. All rights reserved.
//

import UIKit

struct LKAPIError {
    private static let domain = "com.fullstackpug.op-gg"
    static let BadRequest = NSError(domain: domain, code: 400, userInfo: ["NSLocalizedDescription":"Bad Request"])
    static let Unauthorized = NSError(domain: domain, code: 401, userInfo: ["NSLocalizedDescription":"Unauthorized Request"])
    static let NotFound = NSError(domain: domain, code: 404, userInfo: ["NSLocalizedDescription":"Data Not Found"])
    static let RateLimitExceeded = NSError(domain: domain, code: 429, userInfo: ["NSLocalizedDescription":"Rate Limit Exceeded"])
    static let NoResponse = NSError(domain: domain, code: 444, userInfo: ["NSLocalizedDescription":"No Response"])
    static let InternalServerError = NSError(domain: domain, code: 500, userInfo: ["NSLocalizedDescription":"Internal Server Error"])
    static let ServiceUnavailable = NSError(domain: domain, code: 503, userInfo: ["NSLocalizedDescription":"Service Unavailable"])
    static let Unknown = NSError(domain: domain, code: 520, userInfo: ["NSLocalizedDescription":"Unknown Error"])
    static func FromCode(code : Int) -> NSError {
        switch(code){
        case 400:
            return BadRequest
        case 401:
            return Unauthorized
        case 404:
            return NotFound
        case 429:
            return RateLimitExceeded
        case 444:
            return NoResponse
        case 500:
            return InternalServerError
        case 503:
            return ServiceUnavailable
        default:
            return Unknown
        }
    }
}
