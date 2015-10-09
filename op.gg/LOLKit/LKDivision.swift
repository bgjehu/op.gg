//
//  LKDivision.swift
//  op.gg
//
//  Created by Jieyi Hu on 10/7/15.
//  Copyright © 2015 fullstackpug. All rights reserved.
//

import UIKit

enum LKDivision: String {
    case I = "I"
    case II = "II"
    case III = "III"
    case IV = "IV"
    case V = "V"
    var value : Int {
        switch(self){
        case .I:
            return 4
        case .II:
            return 3
        case .III:
            return 2
        case .IV:
            return 1
        case .V:
            return 0
        }
    }
    var stringValue : String {
        return String(5 - value)
    }
}
