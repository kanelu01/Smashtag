//
//  RecentSearchTableViewController.swift
//  Smashtag
//
//  Created by Lucas Kane on 4/19/16.
//  Copyright © 2016 Lucas Kane. All rights reserved.
//

import UIKit

// Show the most recent search terms

class RecentSearchTableViewController: UITableViewController {
    
    private let userDefaults = UserDefaults()
    
    private var recentSearches: [String] {
        return userDefaults.fetchSearchTerms()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Recent Searches"
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    private struct Storyboard {
        static let TableViewReusableCellIdentifier = "RecentSearch"
        static let SegueIdentifier = "Show Tweets"
    }
    
    //Set the unwind action
    @IBAction func unwindToMainMenu(sender: UIStoryboardSegue) {
    }
    
    
    //MARK: - UITableViewDelegate
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentSearches.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.TableViewReusableCellIdentifier, forIndexPath: indexPath)
        
        cell.textLabel?.text = recentSearches[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            userDefaults.deleteSearchTerm(removeAtIndexPath: indexPath)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Storyboard.SegueIdentifier:
                if let cell = sender as? UITableViewCell, let text = cell.textLabel?.text {
                    if let tvc = segue.destinationViewController as? TweetTableViewController {
                        tvc.searchText = text
                    }
                }
            default: break
            }
        }
    }
}
