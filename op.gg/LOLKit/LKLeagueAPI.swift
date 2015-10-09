//
//  LKLeagueAPI.swift
//  op.gg
//
//  Created by Jieyi Hu on 10/7/15.
//  Copyright © 2015 fullstackpug. All rights reserved.
//

import UIKit

public class LKLeagueAPI: LKAPIProtocol {
    
    private var _key : String!
    public var key : String {get{return _key}}
    private let _name = "league"
    public var name : String {get{return _name}}
    private let _version = "v2.5"
    public var version : String {get{return _version}}
    private let _supportedServers = LKServer.nonTestingServers()
    public var supportedServers : [LKServer] { get {return _supportedServers}}
    public var delegate : LKLeagueAPIDelegate?
    required public init(key: String) {
        self._key = key
    }
    
    public func retrieveLeagueData(server : LKServer, bySummonerId summonerId : String) {
        let url = NSURL(string: "https://\(server.rawValue).api.pvp.net/api/lol/\(server.rawValue)/\(version)/\(name)/by-summoner/\(summonerId)/entry?api_key=\(key)")!
        NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                //  local error
                print(error)
                self.delegate?.leagueAPI?(failedRetrieveSummonerLeagueDataReturns: error)
            } else {
                //  no local error
                if let response = response as? NSHTTPURLResponse {
                    //  got response
                    let statusCode = response.statusCode
                    if statusCode == 200 {
                        //  Success OK status
                        if let data = data where data.length > 0 {
                            //  there is data
                            self.delegate?.leagueAPI?(didRetrieveSummonerLeagueData: data)
                        } else {
                            //  no data
                            self.delegate?.leagueAPI?(failedRetrieveSummonerLeagueDataReturns: LKAPIError.NotFound.ToNSError(["Error" : "Summoner Not Found"]))
                        }
                    } else {
                        if let apiError = LKAPIError(rawValue: statusCode)?.ToNSError(["Error" : "Summoner Not Found"]) {
                            //  apiError
                            self.delegate?.leagueAPI?(failedRetrieveSummonerLeagueDataReturns: apiError)
                        } else {
                            //  unknow apiError
                            self.delegate?.leagueAPI?(failedRetrieveSummonerLeagueDataReturns: LKAPIError.Unknown.ToNSError())
                        }
                    }
                } else {
                    //  no response
                    self.delegate?.leagueAPI?(failedRetrieveSummonerLeagueDataReturns: LKAPIError.NoResponse.ToNSError())
                }
            }
        }).resume()
    }
}
