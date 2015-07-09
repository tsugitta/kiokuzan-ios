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
  
  func getImage() -> UIImage{
    
    // キャプチャする範囲を取得.
    var rect = self.bounds
    
    // ビットマップ画像のcontextを作成.
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 1.5)
    var context: CGContextRef = UIGraphicsGetCurrentContext()
    // 対象のview内の描画をcontextに複写する.
    
    self.layer.renderInContext(context)
    
    var pngData = UIImagePNGRepresentation(UIGraphicsGetImageFromCurrentImageContext())
    
    // 現在のcontextのビットマップをUIImageとして取得.
    var capturedImage = UIImage(data: pngData)
    
    // contextを閉じる.
    UIGraphicsEndImageContext()
    
    return capturedImage!
  }
}