//
//  LKSummonerAPI.swift
//  op.gg
//
//  Created by Jieyi Hu on 10/7/15.
//  Copyright © 2015 fullstackpug. All rights reserved.
//

import UIKit

public class LKSummonerAPI: LKAPIProtocol {
    
    private var _key : String!
    public var key : String {get{return _key}}
    private let _name = "summoner"
    public var name : String {get{return _name}}
    private let _version = "v1.4"
    public var version : String {get{return _version}}
    private let _supportedServers = LKServer.nonTestingServers()
    public var supportedServers : [LKServer] { get {return _supportedServers}}
    public var delegate : LKSummonerAPIDelegate?
    required public init(key: String) {
        self._key = key
    }
    
    public func retrieveSummonerData(server : LKServer, var bySummonerName summonerName : String) {
        summonerName = summonerName.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        let url = NSURL(string: "https://\(server.rawValue).api.pvp.net/api/lol/\(server.rawValue)/\(version)/\(name)/by-name/\(summonerName)?api_key=\(key)")!
        NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                //  local error
                print(error)
                self.delegate?.summonerAPI?(failedRetrieveSummoerDataReturns: error)
            } else {
                //  no local error
                if let response = response as? NSHTTPURLResponse {
                    //  got response
                    let statusCode = response.statusCode
                    if statusCode == 200 {
                        //  Success OK status
                        if let data = data where data.length > 0 {
                            //  there is data
                            self.delegate?.summonerAPI?(didRetrieveSummonerData: data)
                        } else {
                            //  no data
                            self.delegate?.summonerAPI?(failedRetrieveSummoerDataReturns: LKAPIError.NotFound)
                        }
                    } else {
                        //  error response code
                        self.delegate?.summonerAPI?(failedRetrieveSummoerDataReturns: LKAPIError.FromCode(statusCode))
                    }
                } else {
                    //  no response
                    self.delegate?.summonerAPI?(failedRetrieveSummoerDataReturns: LKAPIError.NoResponse)
                }
            }
        }).resume()
    }
}
