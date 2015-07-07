//
//  ViewController.swift
//  kiokuzan
//
//  Created by sdklt on 2015/07/04.
//  Copyright (c) 2015年 sdklt. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {
  @IBOutlet weak var highScoreLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(animated: Bool) {
    let defaults = NSUserDefaults.standardUserDefaults()
    var highScoreCountNum: AnyObject! = defaults.objectForKey("highScoreCountNum")
    if highScoreCountNum != nil {
      highScoreLabel.text = "High Score: \(ConvertTimerCountNumToString(highScoreCountNum as! Int))"
    } else {
      highScoreLabel.text = ""
    }
  }
  
  func ConvertTimerCountNumToString(countNum: Int) -> String {
    let ms = countNum % 100
    let s = (countNum - ms) / 100 % 60
    let m = (countNum - s - ms) / 6000 % 3600
    return String(format: "%02d:%02d:%02d", m, s, ms)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func unwindToTop(segue: UIStoryboardSegue) {
  }
}

