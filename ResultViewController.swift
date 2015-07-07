//
//  ResultViewController.swift
//  kiokuzan
//
//  Created by sdklt on 2015/07/07.
//  Copyright (c) 2015年 sdklt. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
  @IBOutlet weak var backLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var missLabel: UILabel!
  @IBOutlet weak var highScoreLabel: UILabel!
  var timerCountNum: Int!
  var missCount: Int!
  var backNumber: Int!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.backLabel.text = "\(self.backNumber) back"
    self.scoreLabel.text = convertTimerCountNumToString(timerCountNum)
    self.missLabel.text = "(miss: \(self.missCount))"
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var highScoreCountNum: AnyObject! = defaults.objectForKey("\(backNumber)BackHighScoreCountNum")
    if highScoreCountNum == nil || timerCountNum < highScoreCountNum as! Int {
      highScoreCountNum = timerCountNum
      defaults.setObject(highScoreCountNum, forKey: "\(backNumber)BackHighScoreCountNum")
    }
    self.highScoreLabel.text = "High Score \(convertTimerCountNumToString(highScoreCountNum as! Int))"
  }

  func convertTimerCountNumToString(countNum: Int) -> String {
    let ms = countNum % 100
    let s = (countNum - ms) / 100 % 60
    let m = (countNum - s - ms) / 6000 % 3600
    return String(format: "%02d:%02d:%02d", m, s, ms)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
