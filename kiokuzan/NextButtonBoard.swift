//
//  NextButtonBoard.swift
//  kiokuzan
//
//  Created by sdklt on 2015/07/07.
//  Copyright (c) 2015年 sdklt. All rights reserved.
//

import UIKit

protocol NextButtonBoardDelegate {
  func pushedNext()
}

class NextButtonBoard: UIView {
  var delegate: NextButtonBoardDelegate?
  
  init(screenWidth: Double, screenHeight: Double, viewHeight: Double) {
    super.init(frame: CGRect(x: 0, y: screenHeight - viewHeight, width: screenWidth, height: viewHeight))
    
    var button = UIButton()
    // ボタンの横幅
    var buttonWidth = screenWidth / 2
    // ボタンの縦幅
    var buttonHeight = viewHeight / 3
    // ボタンのx座標
    var buttonPositionX = (screenWidth - buttonWidth) / 2
    // ボタンのy座標
    var buttonPositionY = (viewHeight - buttonHeight) / 2
    // ボタンの配置、サイズ
    button.frame = CGRect(x:buttonPositionX, y:buttonPositionY, width:buttonWidth, height:buttonHeight)
    // border
    button.layer.borderColor = UIColor.pastelBlueColor(0.5).CGColor
    button.layer.borderWidth = 2
    button.layer.cornerRadius = 5
    // title
    button.setTitle("Next", forState: UIControlState.Normal)
    button.setTitleColor(UIColor.pastelBlueColor(0.5), forState: UIControlState.Normal)
    // ボタンタップ時のアクション
    button.addTarget(self, action: "buttonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
    // ボタン配置
    self.addSubview(button)
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func buttonTapped(sender:UIButton){
    self.delegate?.pushedNext()
  }
}
