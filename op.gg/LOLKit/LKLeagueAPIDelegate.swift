//
//  LKLeagueAPIDelegate.swift
//  op.gg
//
//  Created by Jieyi Hu on 10/7/15.
//  Copyright © 2015 fullstackpug. All rights reserved.
//

import UIKit

@objc public protocol LKLeagueAPIDelegate {
    optional func leagueAPI(didRetrieveSummonerLeagueData data : NSData)
    optional func leagueAPI(failedRetrieveSummonerLeagueDataReturns error : NSError)
}
