//
//  CustomButton.swift
//  kiokuzan
//
//  Created by sdklt on 2015/07/04.
//  Copyright (c) 2015年 sdklt. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
  var backGroundColorBefore: UIColor!
  
  @IBInspectable var textColor: UIColor?
  
  @IBInspectable var cornerRadius: CGFloat = 0 {
    didSet {
      layer.cornerRadius = cornerRadius
    }
  }
  
  @IBInspectable var borderWidth: CGFloat = 0 {
    didSet {
      layer.borderWidth = borderWidth
    }
  }
  
  @IBInspectable var borderColor: UIColor = UIColor.clearColor() {
    didSet {
      layer.borderColor = borderColor.CGColor
    }
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    super.touchesBegan(touches, withEvent: event)
    self.touchStartAnimation()
  }
  
  override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
    super.touchesCancelled(touches, withEvent: event)
    self.touchEndAnimation()
  }
  
  override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
    super.touchesEnded(touches, withEvent: event)
    self.touchEndAnimation()
  }
  
  private func touchStartAnimation(){
    UIView.animateWithDuration(0.05,
      delay: 0.1,
      options: UIViewAnimationOptions.CurveEaseIn,
      animations: {() -> Void in
        self.transform = CGAffineTransformMakeScale(0.95, 0.95);
        self.backGroundColorBefore = self.backgroundColor
        self.backgroundColor = UIColor.pastelBlueColor(0.2)
      },
      completion: nil
    )
  }
  
  private func touchEndAnimation(){
    UIView.animateWithDuration(0.1,
      delay: 0.1,
      options: UIViewAnimationOptions.CurveEaseIn,
      animations: {() -> Void in
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.backgroundColor = self.backGroundColorBefore
      },
      completion: nil
    )
  }
}