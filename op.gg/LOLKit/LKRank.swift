//
//  LKRank.swift
//  op.gg
//
//  Created by Jieyi Hu on 10/7/15.
//  Copyright © 2015 fullstackpug. All rights reserved.
//

import UIKit

public struct LKRank {
    var unranked = true
    var tier : LKTier?
    var division : LKDivision?
    var value : Int {
        get{
            return unranked ? -1 : (tier!.value * 10 + division!.value)
        }
    }
    var stringValue : String {
        get{
            return unranked ? "unranked" : "\(tier!.stringValue)_\(division!.stringValue)"
        }
    }
    init(){
    }
    init(tier : LKTier, division : LKDivision) {
        self.tier = tier
        self.division = division
        unranked = false
    }
}
