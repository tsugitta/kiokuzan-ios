//
//  InputBoard.swift
//  kiokuzan
//
//  Created by sdklt on 2015/07/04.
//  Copyright (c) 2015年 sdklt. All rights reserved.
//

import UIKit

protocol InputBoardDelegate {
  func pushedNumber(numberText: String)
}
class InputBoard: UIView {
  let xButtonCount = 3 // 一行に配置するボタンの数
  let yButtonCount = 4 // 一列
  let buttonMargin = 10.0 // ボタン間の余白
  var delegate: InputBoardDelegate?
  
  init(screenWidth: Double, screenHeight: Double, viewHeight: Double) {
    super.init(frame: CGRect(x: 0, y: screenHeight - viewHeight, width: screenWidth, height: viewHeight))

    let buttonLabels = [
      "1","2","3",
      "4","5","6",
      "7","8","9",
      "","0","Pass",
    ]
    
    for var y=0; y<yButtonCount; y++ {
      for var x=0; x<xButtonCount; x++ {
        if (y == 3 && x == 0) {
          continue
        }
        //計算機のボタン作成
        var button = UIButton()
        //ボタンの横幅
        var buttonWidth = (screenWidth - (buttonMargin * (Double(xButtonCount)+1)))/Double(xButtonCount)
        //ボタンの縦幅
        var buttonHeight = (viewHeight - ((buttonMargin*Double(yButtonCount)+1)))/Double(yButtonCount)
        //ボタンのx座標
        var buttonPositionX = (screenWidth - buttonMargin) / Double(xButtonCount) * Double(x) + buttonMargin
        //ボタンのy座標
        var buttonPositionY = (viewHeight - buttonMargin) / Double(yButtonCount) * Double(y) + buttonMargin
        //ボタンの配置、サイズ
        button.frame = CGRect(x:buttonPositionX, y:buttonPositionY, width:buttonWidth, height:buttonHeight)
        //背景
        button.layer.borderColor = UIColor.pastelBlueColor(0.5).CGColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        //ボタンのラベルタイトル
        var buttonNumber = y * xButtonCount + x
        //ボタンのラベルタイトルを取り出すインデックス番号
        button.setTitle(buttonLabels[buttonNumber],forState: UIControlState.Normal)
        button.setTitleColor(UIColor.pastelBlueColor(0.5), forState: UIControlState.Normal)
        //ボタンタップ時のアクション
        button.addTarget(self, action: "buttonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        //ボタン配置
        self.addSubview(button)
      }
    }
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

  //ボタンタップメソッド
  func buttonTapped(sender:UIButton){
    var tappedButtonTitle:String = sender.titleLabel!.text!
    self.delegate?.pushedNumber(tappedButtonTitle)
  }
}
