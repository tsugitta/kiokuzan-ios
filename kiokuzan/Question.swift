//
//  Question.swift
//  kiokuzan
//
//  Created by sdklt on 2015/07/05.
//  Copyright (c) 2015年 sdklt. All rights reserved.
//

import UIKit

class Question: NSObject {
  let first_item: Int
  let operator_symbol: String // 演算子
  let second_item: Int
  let answer: Int
  
  override init() {
    // 式の答えを決める
    self.answer = Int(arc4random()) % 10
    
    
    // 演算子を決める
    let operator_array = ["+","-","×","÷"]
    self.operator_symbol = operator_array[Int(arc4random()) % 4]
    
    
    // 演算子と答えに応じて各項を決める
    switch self.operator_symbol {
    case "+": // 足し算の場合、各項は答え以下の整数
      self.first_item = Int(arc4random()) % (self.answer + 1)
      self.second_item = self.answer - self.first_item
      
    case "-": // 引き算の場合、第一項は答え以上の整数（ここでは答え+10を最大値とする）
      self.first_item = self.answer + Int(arc4random()) % 11
      self.second_item = self.first_item - self.answer
      
    case "×": // 掛け算の場合、それぞれの項は答えの約数。答えが0の場合はどちらかの項を0にし、もう一方を適当に決める。
      if (self.answer == 0) {
        var item_a = 0
        var item_b = Int(arc4random() % 20)
        if (Int(arc4random()) % 2 == 0) {
          var temp = item_a
          item_a = item_b
          item_b = temp
        }
        self.first_item = item_a
        self.second_item = item_b
      } else {
        self.first_item = self.answer.returnRandomDivisoraFactor()
        self.second_item = self.answer / self.first_item
      }
      
    case "÷": // 割り算の場合、それぞれの項が20未満になるよう適当に選ぶ。
      if (self.answer == 0) {
        self.first_item = 0
        self.second_item = Int(arc4random()) % 19 + 1
      } else {
        self.second_item = Int(arc4random()) % (19 / self.answer) + 1
        self.first_item = self.second_item * self.answer
      }
      
    default: // 実行されることは無いが、各プロパティをセットしないと、initiallizeされていないと怒られてしまう
      self.first_item = 0
      self.second_item = 0
    }
  }
  
  class func generateQuestionArray() -> [Question] {
    var question_array: [Question] = []
    for i in 1...30 {
      question_array.append(Question())
    }
    return question_array
  }
  
  func print() { // for debug
    println("\(first_item) \(operator_symbol) \(second_item) = \(answer)")
  }
}

extension Int {
  func returnRandomDivisoraFactor() -> Int {
    if (self <= 0) {
      return Int(0)
    } else {
      var divisora_factors: [Int] = []
      for i in 1...self {
        if self % i == 0 {
          divisora_factors.append(i)
        }
      }
      return divisora_factors[Int(arc4random()) % divisora_factors.count]
    }
  }
}
