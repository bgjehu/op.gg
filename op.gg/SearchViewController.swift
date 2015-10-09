//
//  SearchViewController.swift
//  op.gg
//
//  Created by Jieyi Hu on 10/6/15.
//  Copyright © 2015 fullstackpug. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, LKSummonerAPIDelegate, LKLeagueAPIDelegate, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet var rankLabel: UILabel!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var maskView: UIView!
    @IBOutlet var rankImageView: UIImageView!
    @IBOutlet var searchProgressBar: UIProgressView!
    @IBOutlet var searchHistoryTableView: UITableView!
    
    var searchingSummoner : LKSummoner?
    var summonerAPI = LKSummonerAPI(key: "67284758-4db7-4699-a6da-9117bd737434")
    var leagueAPI = LKLeagueAPI(key: "67284758-4db7-4699-a6da-9117bd737434")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        summonerAPI.delegate = self
        leagueAPI.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let summonerName = searchBar.text {
            searchSummoner(summonerName)
            searchBar.text = ""
        }
    }
    
    func searchBarResultsListButtonClicked(searchBar: UISearchBar) {
        toggleSearchHistoryTableView()
    }
    
    func summonerAPI(didRetrieveSummonerData data: NSData) {
        if let summoner = searchingSummoner {
            summoner.importSummonerData(data)
            leagueAPI.retrieveLeagueData(LKServer.NA, bySummonerId: summoner.id)
        }
    }
    
    func summonerAPI(failedRetrieveSummoerDataReturns error: NSError) {
        print(error)
        //  UI response on main thread
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func leagueAPI(didRetrieveSummonerLeagueData data: NSData) {
        if let summoner = searchingSummoner {
            //  UI response on main thread
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                summoner.importLeagueData(data)
                self.showRank(summoner.rank)
                SearchHistory.sharedHistory.add(summoner.name)
                self.searchHistoryTableView.reloadData()
            })
        }
    }
    
    func leagueAPI(failedRetrieveSummonerLeagueDataReturns error: NSError) {
        if let summoner = searchingSummoner {
            summoner.setRank(LKRank())
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.showRank(summoner.rank)
                SearchHistory.sharedHistory.add(summoner.name)
                self.searchHistoryTableView.reloadData()
            })
        } else {
            print(error)
            //  UI response on main thread
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    func searchSummoner(summonerName : String) {
        searchingSummoner = LKSummoner(summonerName: summonerName)
        summonerAPI.retrieveSummonerData(LKServer.NA, bySummonerName: summonerName)
    }
    
    func showRank(rank : LKRank) {
        searchBar.resignFirstResponder()
        self.rankLabel.text = rank.stringValue
        self.rankImageView.image = UIImage(named: rank.stringValue)
        self.rankImageView.hidden = false
        self.maskView.hidden = false
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.rankImageView.alpha = 1
            self.maskView.alpha = 0.5
        })
    }
    
    func hideRank() {
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.rankImageView.alpha = 0
            self.maskView.alpha = 0
            }) { (complete) -> Void in
                self.rankImageView.hidden = true
                self.maskView.hidden = true
        }
    }
    
    func toggleSearchHistoryTableView() {
        if searchHistoryTableView.hidden {
            searchHistoryTableView.hidden = false
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.searchHistoryTableView.alpha = 1
            })
        } else {
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.searchHistoryTableView.alpha = 0
                }, completion: { (complete) -> Void in
                    self.searchHistoryTableView.hidden = true
            })
        }
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            hideRank()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchHistory.sharedHistory.searchEntries.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchEntryCell")!
        let maxIndex = SearchHistory.sharedHistory.searchEntries.count - 1
        let index = maxIndex - indexPath.row
        (cell.viewWithTag(1) as! UILabel).text = SearchHistory.sharedHistory.searchEntries[index]
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let maxIndex = SearchHistory.sharedHistory.searchEntries.count - 1
        let index = maxIndex - indexPath.row
        searchSummoner(SearchHistory.sharedHistory.searchEntries[index])
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
