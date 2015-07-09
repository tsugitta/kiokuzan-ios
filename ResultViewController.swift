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
  @IBOutlet weak var scoreView: CustomView!

  @IBOutlet weak var marginTopOfScore: NSLayoutConstraint!
  @IBOutlet weak var marginTopOfCustomView: NSLayoutConstraint!
  @IBOutlet weak var marginLeftOfCustomView: NSLayoutConstraint!
  @IBOutlet weak var marginRightOfCustomView: NSLayoutConstraint!
  @IBOutlet weak var marginLeftOfBackButton: NSLayoutConstraint!
  @IBOutlet weak var marginRightOfBackButton: NSLayoutConstraint!
  @IBOutlet weak var marginTopOfBackButton: NSLayoutConstraint!
  @IBOutlet weak var marginBottomOfBackButton: NSLayoutConstraint!

  @IBOutlet weak var facebookButton: UIButton!
  @IBOutlet weak var twitterButton: UIButton!
  
  var timerCountNum: Int!
  var missCount: Int!
  var backNumber: Int!

  var scoreImage: UIImage!
  
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
    
    self.facebookButton.addTarget(self, action: "tapShareButton:", forControlEvents: UIControlEvents.TouchUpInside)
    self.twitterButton.addTarget(self, action: "tapShareButton:", forControlEvents: UIControlEvents.TouchUpInside)
  }

  override func viewDidAppear(animated: Bool) {
    self.scoreImage = scoreView.getImage()
  }
  
  func tapShareButton(sender: UIButton) {
    var shareVC: SLComposeViewController!
    if sender.tag == 1 {
      shareVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
    } else if sender.tag == 2 {
      shareVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
    }
    shareVC.setInitialText("I scored '\(self.timerCountNum.convertToStringTime())' in the iOS game kiokuzan. #kiokuzan #\(self.backNumber)back")
//    shareVC.addURL(NSURL("http:google.com"))
    shareVC.addImage(self.scoreImage)
    presentViewController(shareVC, animated: true, completion: nil)
  }

  func changeConstrains() {
    switch Double(UIScreen.mainScreen().bounds.size.height) {
      case 480:
        self.marginTopOfScore.constant = 0
        self.marginTopOfCustomView.constant = 10
        self.marginLeftOfCustomView.constant = 20
        self.marginRightOfCustomView.constant = 20
        self.marginLeftOfBackButton.constant = 20
        self.marginRightOfBackButton.constant = 20
        self.marginBottomOfBackButton.constant = 20
      case 568:
        self.marginTopOfScore.constant = 30
        self.marginTopOfCustomView.constant = 30
        self.marginTopOfBackButton.constant = 20
      default:
        break
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
