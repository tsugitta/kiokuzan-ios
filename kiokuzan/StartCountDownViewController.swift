//
//  CountDown.swift
//  kiokuzan
//
//  Created by sdklt on 2015/07/07.
//  Copyright (c) 2015年 sdklt. All rights reserved.
//

import UIKit

class StartCountDownViewController: UIViewController  {
  var countNumberLabel: UILabel!
  let countDownMax: Int = 3
  var countDownNum: Int = 3
  var circleView: UIView!
  var animated: Bool = false
  
  override func viewDidLoad() {
    self.countNumberLabel = UILabel(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
    self.countNumberLabel.font = UIFont(name: "HelveticaNeue", size: 54)
    self.countNumberLabel.textColor = UIColor.pastelBlueColor(1.0)
    self.countNumberLabel.textAlignment = NSTextAlignment.Center
    self.countNumberLabel.baselineAdjustment = UIBaselineAdjustment.AlignCenters
    self.view.addSubview(countNumberLabel)
    self.circleView = UIView(frame : CGRectMake((self.view.frame.width/2)-100, (self.view.frame.height/2)-100, 200, 200))
    self.circleView.layer.addSublayer(drawCircle(circleView.frame.width, strokeColor: UIColor.pastelBlueColor(0.2)))
    self.circleView.layer.addSublayer(drawCircle(circleView.frame.width, strokeColor: UIColor.pastelBlueColor(1.0)))
    self.view.addSubview(circleView)
  }
  
  override func viewDidAppear(animated: Bool) {
    if self.animated == false { // unWind時に実行されないように
      self.animated = true
      countDownNum = countDownMax
      countNumberLabel.text = String(countDownNum)
      circleAnimation(circleView.layer.sublayers[1] as! CAShapeLayer)
    }
  }
  
  func drawCircle(viewWidth:CGFloat, strokeColor:UIColor) -> CAShapeLayer {
    var circle: CAShapeLayer = CAShapeLayer()
    let lineWidth: CGFloat = 3
    let viewScale: CGFloat = viewWidth
    let radius: CGFloat = viewScale - lineWidth
    circle.path = UIBezierPath(roundedRect: CGRectMake(0, 0, radius, radius), cornerRadius: radius / 2).CGPath
    circle.position = CGPointMake(lineWidth / 2, lineWidth / 2)
    circle.fillColor = UIColor.clearColor().CGColor
    circle.strokeColor = strokeColor.CGColor
    circle.lineWidth = lineWidth
    return circle
  }
  
  func circleAnimation(layer:CAShapeLayer) {
    var drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
    drawAnimation.setValue(layer, forKey:"animationLayer")
    drawAnimation!.delegate = self
    drawAnimation!.duration = 1.0
    drawAnimation!.repeatCount = 1.0
    drawAnimation!.fromValue = 0.0
    drawAnimation!.toValue = 1.0
    drawAnimation!.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    layer.addAnimation(drawAnimation, forKey: "circleAnimation")
  }
  
  override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
    let layer:CAShapeLayer = anim.valueForKey("animationLayer") as! CAShapeLayer
    countDownNum--
    countNumberLabel.text = String(countDownNum)
    
    if countDownNum <= 0 {
      self.circleView.removeFromSuperview()
      self.countNumberLabel.text = ""
      performSegueWithIdentifier("fromStartCountDownToPlaySegue",sender: nil)
    } else {
      circleAnimation(layer)
    }
  }
}