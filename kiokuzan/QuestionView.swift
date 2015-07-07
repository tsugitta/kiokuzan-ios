//
//  QuestionView.swift
//  kiokuzan
//
//  Created by sdklt on 2015/07/07.
//  Copyright (c) 2015年 sdklt. All rights reserved.
//

import UIKit

class QuestionView: UIView {
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.customViewCommonInit()
  }

  func customViewCommonInit(){
    let view = NSBundle.mainBundle().loadNibNamed("QuestionView", owner: self, options: nil).first as! UIView
    view.frame = self.bounds
    view.setTranslatesAutoresizingMaskIntoConstraints(true)
    view.autoresizingMask = UIViewAutoresizing.FlexibleWidth|UIViewAutoresizing.FlexibleHeight
    self.addSubview(view)
  }
}

//class QuestionView: UIView {
//  let screenWidth: Double = Double(UIScreen.mainScreen().bounds.size.width) // 画面の横幅サイズを格納するメンバ変数
//  let screenHeight: Double = Double(UIScreen.mainScreen().bounds.size.height) // 画面の縦
//  var viewHeight: Double! // ビューの高さ
//  var delegate: NextButtonBoardDelegate?
//  
//  init(inputBoardHeight: Double) {
//    viewHeight = screenHeight - inputBoardHeight
//    super.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: viewHeight))
//    self.backgroundColor = UIColor.PastelBlueColor(0.1)
//    
//    var button = UIButton()
//    // ボタンの横幅
//    var buttonWidth = screenWidth / 2
//    // ボタンの縦幅
//    var buttonHeight = viewHeight / 3
//    // ボタンのx座標
//    var buttonPositionX = (screenWidth - buttonWidth) / 2
//    // ボタンのy座標
//    var buttonPositionY = (viewHeight - buttonHeight) / 2
//    // ボタンの配置、サイズ
//    button.frame = CGRect(x:buttonPositionX, y:buttonPositionY, width:buttonWidth, height:buttonHeight)
//    // border
//    button.layer.borderColor = UIColor.PastelBlueColor(0.5).CGColor
//    button.layer.borderWidth = 2
//    button.layer.cornerRadius = 5
//    // title
//    button.setTitle("Next", forState: UIControlState.Normal)
//    button.setTitleColor(UIColor.PastelBlueColor(0.5), forState: UIControlState.Normal)
//    // ボタンタップ時のアクション
//    button.addTarget(self, action: "buttonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
//    // ボタン配置
//    self.addSubview(button)
//  }
//  
//  required init(coder aDecoder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//  
//  // ボタンタップメソッド
//  func buttonTapped(sender:UIButton){
//    self.delegate?.goNext()
//  }
//}