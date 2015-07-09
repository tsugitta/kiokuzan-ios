//
//  DescriptionViewController.swift
//  kiokuzan
//
//  Created by sdklt on 2015/07/08.
//  Copyright (c) 2015年 sdklt. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {
  @IBOutlet weak var marginTopOfTitle: NSLayoutConstraint!
  @IBOutlet weak var marginTopOfCustomView: NSLayoutConstraint!
  @IBOutlet weak var marginTopOf1stDescription: NSLayoutConstraint!
  @IBOutlet weak var marginTopOf2ndDescription: NSLayoutConstraint!
  @IBOutlet weak var marginTopOf3rdDescription: NSLayoutConstraint!
  @IBOutlet weak var marginTopOf4thDescription: NSLayoutConstraint!
  @IBOutlet weak var marginBottomOf4thDescription: NSLayoutConstraint!
  override func viewDidLoad() {
    super.viewDidLoad()
  
    self.changeConstrains()
    
    self.view.backgroundColor = UIColor.pastelLightBlueColor(1)
  }

  func changeConstrains() {
    switch Double(UIScreen.mainScreen().bounds.size.height) {
    case 480:
      self.marginTopOfTitle.constant = 20
      self.marginTopOf1stDescription.constant = 8
      self.marginTopOf2ndDescription.constant = 8
      self.marginTopOf3rdDescription.constant = 8
      self.marginTopOf4thDescription.constant = 8
      self.marginBottomOf4thDescription.constant = 8
    case 568:
      self.marginTopOfTitle.constant = 60
    case 667:
      marginTopOfCustomView.constant = 40
    case 736:
      marginTopOfCustomView.constant = 80
    default:
      break
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
