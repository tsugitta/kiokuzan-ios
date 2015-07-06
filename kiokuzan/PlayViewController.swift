//
//  PlayViewController.swift
//  kiokuzan
//
//  Created by sdklt on 2015/07/04.
//  Copyright (c) 2015年 sdklt. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {

    override func viewDidLoad() {
      super.viewDidLoad()
      let inputBoard = InputBoard()
      self.view.addSubview(inputBoard)
      
    }

    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
    }
  
}
