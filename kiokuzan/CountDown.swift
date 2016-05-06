//
//  CountDown.swift
//  kiokuzan
//
//  Created by sdklt on 2015/07/07.
//  Copyright (c) 2015年 sdklt. All rights reserved.
//

import UIKit

class StartCountDownControllerView: UIViewController {

  var _countNumberLabel: UILabel!
  let _countDownMax: Int = 3
  var _countDownNum: Int = 3
  var _circleView: UIView!

  override func viewDidLoad() {

    // カウントダウン数値ラベル設定
    _countNumberLabel = UILabel(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
    _countNumberLabel.font = UIFont(name: "HelveticaNeue", size: 54)
    // 中心揃え
    _countNumberLabel.textAlignment = NSTextAlignment.Center
    _countNumberLabel.baselineAdjustment = UIBaselineAdjustment.AlignCenters
    self.view.addSubview(_countNumberLabel)

    _circleView = UIView(frame : CGRectMake((self.view.frame.width/2)-100, (self.view.frame.height/2)-100, 200, 200))
    _circleView.layer.addSublayer(drawCircle(_circleView.frame.width, strokeColor: UIColor(red:0.0,green:0.0,blue:0.0,alpha:0.2)))
    _circleView.layer.addSublayer(drawCircle(_circleView.frame.width, strokeColor: UIColor(red:0.0,green:0.0,blue:0.0,alpha:1.0)))
    self.view.addSubview(_circleView)
  }

  // 遷移毎に実行
  override func viewWillAppear(animated: Bool) {
    // 数値をリセット
    _countDownNum = _countDownMax
    _countNumberLabel.text = String(_countDownNum)
    // アニメーション開始
    circleAnimation(_circleView.layer.sublayers[1] as! CAShapeLayer)
  }

  func drawCircle(viewWidth: CGFloat, strokeColor: UIColor) -> CAShapeLayer {
    var circle: CAShapeLayer = CAShapeLayer()
    // ゲージ幅
    let lineWidth: CGFloat = 20
    // 描画領域のwidth
    let viewScale: CGFloat = viewWidth
    // 円のサイズ
    let radius: CGFloat = viewScale - lineWidth
    // 円の描画path設定
    circle.path = UIBezierPath(roundedRect: CGRectMake(0, 0, radius, radius), cornerRadius: radius / 2).CGPath
    // 円のポジション設定
    circle.position = CGPointMake(lineWidth / 2, lineWidth / 2)
    // 塗りの色を設定
    circle.fillColor = UIColor.clearColor().CGColor
    // 線の色を設定
    circle.strokeColor = strokeColor.CGColor
    // 線の幅を設定
    circle.lineWidth = lineWidth
    return circle   }

  func circleAnimation(layer: CAShapeLayer) {
    // アニメーションkeyを設定
    var drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
    // callbackで使用
    drawAnimation.setValue(layer, forKey:"animationLayer")
    // callbackを使用する場合
    drawAnimation!.delegate = self
    // アニメーション間隔の指定
    drawAnimation!.duration = 1.0
    // 繰り返し回数の指定
    drawAnimation!.repeatCount = 1.0
    // 起点と目標点の変化比率を設定 (0.0 〜 1.0)
    drawAnimation!.fromValue = 0.0
    drawAnimation!.toValue = 1.0
    // イージング設定
    drawAnimation!.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)

    layer.addAnimation(drawAnimation, forKey: "circleAnimation")
  }

  override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
    let layer: CAShapeLayer = anim.valueForKey("animationLayer") as! CAShapeLayer
    _countDownNum--
    // 表示ラベルの更新
    _countNumberLabel.text = String(_countDownNum)

    if _countDownNum <= 0 {
      //次の画面へ遷移(navigationControllerの場合)
      //let nextViewController:ViewController = ViewController()
      //self.navigationController?.pushViewController(nextViewController, animated: false)

    } else {
      circleAnimation(layer)
    }
  }

}
