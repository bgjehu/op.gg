//
//  LKSummoner.swift
//  op.gg
//
//  Created by Jieyi Hu on 10/7/15.
//  Copyright © 2015 fullstackpug. All rights reserved.
//

import UIKit

public class LKSummoner: NSObject {
    private var _id : String = ""
    public var id : String { get {return _id}}
    private var _name : String = ""
    public var name : String { get {return _name}}
    public var nameString : String { get{
        return _name.lowercaseString.stringByReplacingOccurrencesOfString(" ", withString: "")
    }}
    private var _profileIconId : Int = -1
    public var profileIconId : Int { get {return _profileIconId}}
    private var _revisionDate : String = ""
    public var revisionDate : String { get {return _revisionDate}}
    
    private var _summonerLevel : Int = -1
    public var summonerLevel : Int { get {return _summonerLevel}}
    private var _rank = LKRank()
    public var rank : LKRank { get {return _rank}}
    private var _teamRank = LKRank()
    public var teamRank : LKRank { get {return _teamRank}}
    public var highestRank : LKRank { get {return _rank.value >= teamRank.value ? _rank : _teamRank}}
    
    private var _containsSummonerData = false
    public var containsSummonerData : Bool { get {return _containsSummonerData}}
    
    public init(summonerName : String) {
        _name = summonerName
    }
    
    public func importSummonerData(jsonData : NSData) -> Bool {
        do {
            if let data = (try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as? [String : [String : AnyObject]]) {

                let summonerData = data[nameString]!
                self._id = String(summonerData["id"]!)
                self._name = summonerData["name"]! as! String
                self._profileIconId = summonerData["profileIconId"]! as! Int
                self._revisionDate = String(summonerData["revisionDate"]!)
                self._summonerLevel = summonerData["summonerLevel"]! as! Int
                self._containsSummonerData = true
                print("imported \(data)")
                return true
                
            } else {
                //  invalid data
                print("invalid data")
                return false
            }
        } catch let error as NSError {
            //  invalid data
            print(error)
            return false
        }
    }
    
    public func importLeagueData(jsonData : NSData) -> Bool {
        if containsSummonerData {
            do {
                if let data = (try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as? [String : [[String : AnyObject]]]) {
                    
                    let rankDataEntries = data[id]!
                    if rankDataEntries.count > 0 {
                        //  has rank entries
                        for rankDataEntry in rankDataEntries {
                            let queue = rankDataEntry["queue"]! as! String
                            let tier = LKTier(rawValue: rankDataEntry["tier"]! as! String)!
                            let division = LKDivision(rawValue: (rankDataEntry["entries"]! as! [[String : AnyObject]])[0]["division"]! as! String)!
                            if queue == "RANKED_SOLO_5x5" {
                                //  solo rank
                                _rank = LKRank(tier: tier, division: division)
                            } else {
                                //  team rank
                                let tmpRank = LKRank(tier: tier, division: division)
                                _teamRank = tmpRank.value >= teamRank.value ? tmpRank : teamRank
                            }
                        }
                    } else {
                        //  no rank entry
                        //  do nothing
                    }
                    print("imported \(data)")
                    return true
                    
                } else {
                    //  invalid data
                    print("invalid data")
                    return false
                }
            } catch let error as NSError {
                //  invalid data
                print(error)
                return false
            }
        } else {
            return false
        }
    }
    
}
