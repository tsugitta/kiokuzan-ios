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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.layer.borderWidth = 1
    self.tableView.layer.borderColor = UIColor.pastelBlueColor(1).CGColor
    self.tableView.layer.cornerRadius = 4
    
  
    
    tableView.delegate = self
    tableView.dataSource = self
    
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return count(records[currentViewType]!)
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("tableCell") as! UITableViewCell
    let record = records[currentViewType]![indexPath.row]
    (cell.viewWithTag(1) as! UILabel).text = "\(indexPath.row + 1)."
    (cell.viewWithTag(2) as! UILabel).text = "\(record.name)"
    (cell.viewWithTag(3) as! UILabel).text = "\(record.scoreTime)"
    (cell.viewWithTag(4) as! UILabel).text = "\(record.createdDate)"
    return cell
  }

  func fetchRecords() {
    Alamofire.request(.GET, "http://localhost:4000/records", parameters: nil)
      .responseJSON {(request, response, JSON, error) in
        if let recordData = JSON as? Dictionary<String, AnyObject> {
          for (backNumber, recordArray) in recordData {
            println(backNumber)
            self.records[backNumber] = []
            println(recordArray)
            for recvRecord in recordArray as! [Dictionary<String, AnyObject>] {
              let record = Record(name: recvRecord["name"] as! String, score: recvRecord["score"] as! Int, createdDate: recvRecord["created_date"] as! String)
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
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
