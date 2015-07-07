//
//  ExtensionInt.swift
//  kiokuzan
//
//  Created by sdklt on 2015/07/07.
//  Copyright (c) 2015年 sdklt. All rights reserved.
//

import UIKit

extension Int {
  func returnRandomDivisoraFactor() -> Int {
    if self <= 0 {
      return Int(0)
    } else {
      var divisora_factors: [Int] = []
      for i in 1...self {
        if self % i == 0 {
          divisora_factors.append(i)
        }
      }
      return divisora_factors[Int.getRandomInt(divisora_factors.count)]
    }
  }
  
  static func getRandomInt(n: Int) -> Int {
    return Int(arc4random_uniform(UInt32(n)))
  }
}

