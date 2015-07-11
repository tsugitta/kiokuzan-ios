//
//  ResultViewController.swift
//  kiokuzan
//
//  Created by sdklt on 2015/07/07.
//  Copyright (c) 2015年 sdklt. All rights reserved.
//

import UIKit
import Social
import Alamofire

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

  @IBAction func tapRankingButton(sender: UIButton) {
    var inputTextField: UITextField!
    let alert:UIAlertController = UIAlertController(title:"Send score",
      message: "Please enter your name.",
      preferredStyle: UIAlertControllerStyle.Alert)
    
    let cancelAction:UIAlertAction = UIAlertAction(title: "Cancel",
      style: UIAlertActionStyle.Cancel,
      handler:{
        (action:UIAlertAction!) -> Void in
    })
    let defaultAction:UIAlertAction = UIAlertAction(title: "OK",
      style: UIAlertActionStyle.Default,
      handler:{
        (action:UIAlertAction!) -> Void in
        if count(inputTextField.text) == 0 {
          self.showErrorMessage("Name can't be blank.")
        } else if count(inputTextField.text) >= 10 {
          self.showErrorMessage("Name is too long.")
        } else {
          self.sendData(inputTextField.text)
        }
    })
    alert.addAction(cancelAction)
    alert.addAction(defaultAction)
    
    alert.addTextFieldWithConfigurationHandler({(text:UITextField!) -> Void in
      inputTextField = text
      text.placeholder = "Name"
    })
    self.presentViewController(alert, animated: true, completion: nil)
  }
  
  func sendData(name: String ) {
    var params: [String: AnyObject] = [
      "name": name,
      "score": self.timerCountNum,
      "identity": UIDevice.currentDevice().identifierForVendor.UUIDString,
      "hash_value": timerCountNum * 123 + count(name),
      "type": "\(returnBackNumberText(self.backNumber))BackRecord"
    ]
    Alamofire.request(.POST, "http://52.68.207.77/records", parameters: params, encoding: .JSON).responseJSON { (request, response, JSON, error) in
      if error != nil {
        self.showErrorMessage("Can't connect to server.")
      } else {
        let dicts = JSON as! NSDictionary
        if let errors = dicts["errors"] as? NSDictionary {
          if errors["illegal_post"] != nil {
            self.showErrorMessage("Unknown error.")
          } else if errors["best_score"] != nil {
            var msg = (errors["best_score"] as! NSArray)[0] as! String
            self.showErrorMessage(msg)
          }
        } else if let ranking = dicts["ranking"] as? Int {
          let all_count = dicts["all_count"] as! Int
          let alertController = UIAlertController(title: "Ranking", message: "Your rank is \(ranking) / \(all_count)", preferredStyle: .Alert)
          let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
          alertController.addAction(defaultAction)
          self.presentViewController(alertController, animated: true, completion: nil)
        }
      }
    }
  }
  
  func showErrorMessage(message: String) {
    let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
    alertController.addAction(defaultAction)
    self.presentViewController(alertController, animated: true, completion: nil)
  }
  
  func returnBackNumberText(backNumber: Int) -> String{
    switch backNumber {
      case 3:
        return "Three"
      case 5:
        return "Five"
      case 10:
        return "Ten"
      default:
        return ""
    }
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
        self.marginLeftOfCustomView.constant = 30
        self.marginRightOfCustomView.constant = 30
        self.marginLeftOfBackButton.constant = 30
        self.marginRightOfBackButton.constant = 30
      default:
        break
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
