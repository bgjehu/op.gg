//
//  SearchHistory.swift
//  op.gg
//
//  Created by Jieyi Hu on 10/8/15.
//  Copyright © 2015 fullstackpug. All rights reserved.
//

import UIKit

class SearchHistory: NSObject {
    
    private let _capacity = 10
    var capacity : Int {get {return _capacity}}
    private let path = (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as NSString).stringByAppendingPathComponent("searchentries")
    private var _searchEntries : [String]!
    var searchEntries : [String] {get {return _searchEntries}}
    private static var _sharedHistory = SearchHistory()
    static var sharedHistory : SearchHistory {get {return _sharedHistory}}
    
    override init() {
        super.init()
        if !load() {
            //  no history loaded
            _searchEntries = [String]()
        }
    }
    
    func add(searchEntry : String) {
        remove(searchEntry)
        if searchEntries.count == capacity {
            _searchEntries.removeFirst()
        }
        _searchEntries.append(searchEntry)
        store()
    }
    
    func remove(searchEntry : String) {
        for index in 0..<searchEntries.count {
            if searchEntries[index] == searchEntry {
                _searchEntries.removeAtIndex(index)
                break
            }
        }
    }
    
    func reset() {
        _searchEntries = [String]()
    }
    
    func store() -> Bool{
        do{
            let jsonData = try NSJSONSerialization.dataWithJSONObject(_searchEntries, options: NSJSONWritingOptions.PrettyPrinted)
            jsonData.writeToFile(path, atomically: true)
            return true
        } catch let error as NSError {
            print(error)
            return false
        }
    }
    
    func load() -> Bool {
        do{
            if let jsonData = NSData(contentsOfFile: path) {
                if let entries = (try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers)) as? [String] {
                    _searchEntries = entries
                    return true
                } else {
                    //  error reading json
                    return false
                }
            } else {
                //  error reading file
                return false
            }
        } catch let error as NSError {
            print(error)
            return false
        }
    }
}
