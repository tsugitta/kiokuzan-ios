//
//  ResultViewController.swift
//  kiokuzan
//
//  Created by sdklt on 2015/07/07.
//  Copyright (c) 2015年 sdklt. All rights reserved.
//

import UIKit
import Social

class ResultViewController: UIViewController {
  @IBOutlet weak var backLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var missLabel: UILabel!
  @IBOutlet weak var highScoreLabel: UILabel!
  @IBOutlet weak var scoreView: UIView!

  @IBOutlet weak var marginTopOfScore: NSLayoutConstraint!
  @IBOutlet weak var marginTopOfCustomView: NSLayoutConstraint!
  @IBOutlet weak var marginLeftOfCustomView: NSLayoutConstraint!
  @IBOutlet weak var marginRightOfCustomView: NSLayoutConstraint!
  @IBOutlet weak var marginLeftOfBackButton: NSLayoutConstraint!
  @IBOutlet weak var marginRightOfBackButton: NSLayoutConstraint!
  @IBOutlet weak var marginBottomOfBackButton: NSLayoutConstraint!
  
  var timerCountNum: Int!
  var missCount: Int!
  var backNumber: Int!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.changeConstrains()
    self.backLabel.text = "\(self.backNumber) back"
    self.scoreLabel.text = timerCountNum.convertToStringTime()
    self.missLabel.text = "(miss: \(self.missCount))"
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var highScoreCountNum: AnyObject! = defaults.objectForKey("\(backNumber)BackHighScoreCountNum")
    if highScoreCountNum == nil || timerCountNum < highScoreCountNum as! Int {
      highScoreCountNum = timerCountNum
      defaults.setObject(highScoreCountNum, forKey: "\(backNumber)BackHighScoreCountNum")
    }
    self.highScoreLabel.text = "High Score \((highScoreCountNum as! Int).convertToStringTime())"
  }

  @IBAction func pushFaceBook(sender: UIButton) {
    var facebookVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
    facebookVC.setInitialText("google")
//    facebookVC.addURL(NSURL("http:google.com"))
    presentViewController(facebookVC, animated: true, completion: nil)
  }

  @IBAction func pushTwitter(sender: AnyObject) {
    var twitterVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
    twitterVC.setInitialText("I played Kiokuzan \(self.backNumber) back and got score '\(self.timerCountNum.convertToStringTime())'")
//    twitterVC.addURL("http://google.com")
    presentViewController(twitterVC, animated: true, completion: nil)
  }
  
  func changeConstrains() {
    switch Double(UIScreen.mainScreen().bounds.size.height) {
      case 480:
        self.marginTopOfScore.constant = 0
        self.marginTopOfCustomView.constant = 0
        self.marginLeftOfCustomView.constant = 10
        self.marginRightOfCustomView.constant = 10
        self.marginLeftOfBackButton.constant = 10
        self.marginRightOfBackButton.constant = 10
        self.marginBottomOfBackButton.constant = 20
      case 568:
        self.marginTopOfScore.constant = 10
        self.marginTopOfCustomView.constant = 10
        self.marginLeftOfCustomView.constant = 10
        self.marginRightOfCustomView.constant = 10
        self.marginLeftOfBackButton.constant = 10
        self.marginRightOfBackButton.constant = 10
        self.marginBottomOfBackButton.constant = 40
      default:
        break
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
