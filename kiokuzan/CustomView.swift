//
//  CustomView.swift
//  kiokuzan
//
//  Created by sdklt on 2015/07/08.
//  Copyright (c) 2015年 sdklt. All rights reserved.
//

import UIKit

@IBDesignable
class CustomView: UIView {
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
}