//
//  DefineBlueColor.swift
//  kiokuzan
//
//  Created by sdklt on 2015/07/07.
//  Copyright (c) 2015年 sdklt. All rights reserved.
//

import UIKit

extension UIColor {
    class func pastelBlueColor(alpha: CGFloat) -> UIColor {
        return UIColor(red: 24.0 / 255, green: 145.0 / 255, blue: 214.0 / 255, alpha: alpha)
    }

    class func pastelLightBlueColor(alpha: CGFloat) -> UIColor {
        return UIColor(red: 230.0 / 255, green: 240.0 / 255, blue: 255.0 / 255, alpha: alpha)
    }

    class func pastelLightRedColor(alpha: CGFloat) -> UIColor {
        return UIColor(red: 255.0 / 255, green: 230.0 / 255, blue: 230.0 / 255, alpha: alpha)
    }
}
