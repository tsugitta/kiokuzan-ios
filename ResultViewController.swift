//
//  ResultViewController.swift
//  kiokuzan
//
//  Created by sdklt on 2015/07/07.
//  Copyright (c) 2015年 sdklt. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
  var timerCountNum: Int!
  var missCount: Int!
  
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var missLabel: UILabel!
  @IBOutlet weak var highScoreLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.scoreLabel.text = ConvertTimerCountNumToString(timerCountNum)
    self.missLabel.text = "(miss: \(self.missCount))"
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var highScoreCountNum: AnyObject! = defaults.objectForKey("highScoreCountNum")
    if (highScoreCountNum == nil || timerCountNum < highScoreCountNum as! Int) {
      highScoreCountNum = timerCountNum
      defaults.setObject(highScoreCountNum, forKey: "highScoreCountNum")
    }
    
    self.highScoreLabel.text = "High Score: \(ConvertTimerCountNumToString(highScoreCountNum as! Int))"
  }

  func ConvertTimerCountNumToString(countNum: Int) -> String {
    let ms = countNum % 100
    let s = (countNum - ms) / 100 % 60
    let m = (countNum - s - ms) / 6000 % 3600
    return String(format: "%02d:%02d:%02d", m, s, ms)
  }
  
  @IBAction func backButton(sender: UIButton) {
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}
