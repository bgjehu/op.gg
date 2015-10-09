//
//  LKTier.swift
//  op.gg
//
//  Created by Jieyi Hu on 10/7/15.
//  Copyright © 2015 fullstackpug. All rights reserved.
//

import UIKit

enum LKTier : String {
    case Bronze = "BRONZE"
    case Silver = "SILVER"
    case Gold = "GOLD"
    case Platinum = "PLATINUM"
    case Diamond = "DIAMOND"
    case Master = "MASTER"
    case Challenger = "CHALLENGER"
    var value : Int {
        get{
            switch(self){
            case .Bronze:
                return 0
            case .Silver:
                return 1
            case .Gold:
                return 2
            case .Platinum:
                return 3
            case .Diamond:
                return 4
            case .Master:
                return 5
            case .Challenger:
                return 6
            }
        }
    }
    var stringValue : String {
        get{
            return rawValue.lowercaseString
        }
    }
}
