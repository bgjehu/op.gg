//
//  LKSummonerAPIDelegate.swift
//  op.gg
//
//  Created by Jieyi Hu on 10/7/15.
//  Copyright © 2015 fullstackpug. All rights reserved.
//

import UIKit

@objc public protocol LKSummonerAPIDelegate {
    optional func summonerAPI(didRetrieveSummonerData data : NSData)
    optional func summonerAPI(failedRetrieveSummoerDataReturns error : NSError)
}
