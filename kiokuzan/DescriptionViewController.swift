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
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    self.changeConstrains()
    
    self.view.backgroundColor = UIColor.pastelLightBlueColor(1)
  }

  func changeConstrains() {
    switch Double(UIScreen.mainScreen().bounds.size.height) {
    case 480:
      self.marginTopOfTitle.constant = 20
    default:
      break
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
