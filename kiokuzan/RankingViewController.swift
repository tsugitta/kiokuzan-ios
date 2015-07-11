//
//  RankingViewController.swift
//  kiokuzan
//
//  Created by sdklt on 2015/07/10.
//  Copyright (c) 2015年 sdklt. All rights reserved.
//

import UIKit
import Alamofire

class RankingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  @IBOutlet weak var tableView: UITableView!
  var currentViewType = "ThreeBackRecord"
  var records: Dictionary<String, Array<Record>> = ["ThreeBackRecord": [], "FiveBackRecord": [], "TenBackRecord": []]
  
  @IBOutlet weak var marginTopOfTitle: NSLayoutConstraint!
  @IBOutlet weak var marginLeftOfTableView: NSLayoutConstraint!
  @IBOutlet weak var marginRightOfTableView: NSLayoutConstraint!
  @IBOutlet weak var marginLeftOfSegmentedControl: NSLayoutConstraint!
  @IBOutlet weak var marginRightOfSegmentedControl: NSLayoutConstraint!
  @IBOutlet weak var marginLeftOfBackButton: NSLayoutConstraint!
  @IBOutlet weak var marginRightOfBackButton: NSLayoutConstraint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.changeConstraint()
    self.tableView.layer.borderWidth = 1
    self.tableView.layer.borderColor = UIColor.pastelBlueColor(1).CGColor
    self.tableView.layer.cornerRadius = 4
    
    fetchRecords()
    
    tableView.delegate = self
    tableView.dataSource = self
    
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return count(records[currentViewType]!)
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return CGFloat(30)
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("tableCell") as! UITableViewCell
    let record = records[currentViewType]![indexPath.row]
    var sameRank = 0
    while indexPath.row - sameRank > 0 && record.scoreTime == records[currentViewType]![indexPath.row - 1 - sameRank].scoreTime {
      sameRank++
    }
    (cell.viewWithTag(1) as! UILabel).text = "\(indexPath.row + 1 - sameRank)."
    (cell.viewWithTag(2) as! UILabel).text = "\(record.name)"
    (cell.viewWithTag(3) as! UILabel).text = "\(record.scoreTime)"
    return cell
  }

  func fetchRecords() {
    Alamofire.request(.GET, "http://52.68.207.77/records", parameters: nil)
      .responseJSON {(request, response, JSON, error) in
        if let recordData = JSON as? Dictionary<String, AnyObject> {
          for (backNumber, recordArray) in recordData {
            self.records[backNumber] = []
            for recvRecord in recordArray as! [Dictionary<String, AnyObject>] {
              let record = Record(name: recvRecord["name"] as! String, score: recvRecord["score"] as! Int)
              self.records[backNumber]!.append(record)
            }
          }
          self.tableView.reloadData()
        } else {
          let alertController = UIAlertController(title: "Error", message: "Can't connect to server.", preferredStyle: .Alert)
          let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
          alertController.addAction(defaultAction)
          self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
  }
  
  @IBAction func tapBackNumber(sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex {
    case 0:
      self.currentViewType = "ThreeBackRecord"
    case 1:
      self.currentViewType = "FiveBackRecord"
    case 2:
      self.currentViewType = "TenBackRecord"
    default:
      break
    }
    tableView.reloadData()
  }
  
  func changeConstraint() {
    switch Double(UIScreen.mainScreen().bounds.size.height) {
    case 480:
      self.marginTopOfTitle.constant = 20
      self.marginLeftOfTableView.constant = 10
      self.marginRightOfTableView.constant = 10
      self.marginLeftOfSegmentedControl.constant = 10
      self.marginRightOfSegmentedControl.constant = 10
      self.marginLeftOfBackButton.constant = 10
      self.marginRightOfBackButton.constant = 10
    case 568:
      self.marginTopOfTitle.constant = 30
      self.marginLeftOfTableView.constant = 15
      self.marginRightOfTableView.constant = 15
      self.marginLeftOfSegmentedControl.constant = 15
      self.marginRightOfSegmentedControl.constant = 15
      self.marginLeftOfBackButton.constant = 15
      self.marginRightOfBackButton.constant = 15
    default:
      break
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
