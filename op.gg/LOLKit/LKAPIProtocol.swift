//
//  LKAPIProtocol.swift
//  op.gg
//
//  Created by Jieyi Hu on 10/7/15.
//  Copyright © 2015 fullstackpug. All rights reserved.
//

import UIKit

public protocol LKAPIProtocol {
    var name : String {get}
    var version : String {get}
    var supportedServers : [LKServer] {get}
    init(key : String)
}

