//
//  ViewController.swift
//  kiokuzan
//
//  Created by sdklt on 2015/07/04.
//  Copyright (c) 2015年 sdklt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    var subView = InputBoard()
    subView.frame = CGRectMake(30, 30, 30, 30)
    subView.backgroundColor = UIColor.blackColor()
    self.view.addSubview(subView)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

