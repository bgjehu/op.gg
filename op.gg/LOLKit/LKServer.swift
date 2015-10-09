//
//  LKServer.swift
//  op.gg
//
//  Created by Jieyi Hu on 10/7/15.
//  Copyright © 2015 fullstackpug. All rights reserved.
//

import UIKit

public enum LKServer : String{
    case BR = "br"
    case EUNE = "eune"
    case EUW = "euw"
    case KR = "kr"
    case LAN = "lan"
    case LAS = "las"
    case NA = "na"
    case OCE = "oce"
    case PBE = "pbe"
    case RU = "ru"
    case TR = "tr"
    static func nonTestingServers() -> [LKServer] {
        return [LKServer.BR, LKServer.EUNE, LKServer.EUW, LKServer.KR, LKServer.LAN, LKServer.LAS, LKServer.NA, LKServer.OCE, LKServer.RU, LKServer.TR]
    }
}
