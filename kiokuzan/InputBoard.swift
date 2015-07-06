//
//  InputBoard.swift
//  kiokuzan
//
//  Created by sdklt on 2015/07/04.
//  Copyright (c) 2015年 sdklt. All rights reserved.
//

import UIKit

class InputBoard: UIView {

  let xButtonCount = 3 // 一行に配置するボタンの数
  let yButtonCount = 4 // 一列
  let screenWidth:Double = Double(UIScreen.mainScreen().bounds.size.width) // 画面の横幅サイズを格納するメンバ変数
  let screenHeight:Double = Double(UIScreen.mainScreen().bounds.size.height) // 画面の縦
  let buttonMargin = 10.0 // ボタン間の余白
  var inputHeight = 300.0 // 入力領域の高さ
  
  init() {
    super.init(frame: CGRect(x: 0, y: screenHeight - inputHeight, width: screenWidth, height: inputHeight))
    self.backgroundColor = UIColor(red: 24.0 / 255, green: 145.0 / 255, blue: 214.0 / 255, alpha:0.1)
    println(screenHeight)
    println(self.frame)
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
        var buttonHeight = (inputHeight - ((buttonMargin*Double(yButtonCount)+1)))/Double(yButtonCount)
        //ボタンのx座標
        var buttonPositionX = (screenWidth - buttonMargin) / Double(xButtonCount) * Double(x) + buttonMargin
        //ボタンのy座標
        var buttonPositionY = (inputHeight - buttonMargin) / Double(yButtonCount) * Double(y) + buttonMargin
        //ボタンの配置、サイズ
        button.frame = CGRect(x:buttonPositionX, y:buttonPositionY, width:buttonWidth, height:buttonHeight)
        //背景
        button.backgroundColor = UIColor(red: 24.0 / 255, green: 145.0 / 255, blue: 214.0 / 255, alpha:0.5)
        //ボタンのラベルタイトル
        var buttonNumber = y * xButtonCount + x
        //ボタンのラベルタイトルを取り出すインデックス番号
        button.setTitle(buttonLabels[buttonNumber],forState: UIControlState.Normal)
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
    println("\(tappedButtonTitle)ボタンがタップされました")
  }
}
