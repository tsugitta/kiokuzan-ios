//
//  Question.swift
//  kiokuzan
//
//  Created by sdklt on 2015/07/05.
//  Copyright (c) 2015年 sdklt. All rights reserved.
//

import UIKit

class Question: NSObject {
  let firstItem: Int
  let operatorSymbol: String // 演算子
  let secondItem: Int
  let answer: Int
  
  class func returnNumberOfQuestions(backNumber: Int) -> Int {
    var numberOfQuestions: Int!
    switch backNumber {
    case 3:
      numberOfQuestions = 20
    case 5:
      numberOfQuestions = 25
    case 10:
      numberOfQuestions = 30
    default:
      break
    }
    return numberOfQuestions
  }
  
  class func generateQuestionArray(numberOfQuestions: Int) -> [Question] {
    var questionArray: [Question] = []
    for i in 1...numberOfQuestions {
      questionArray.append(Question())
    }
    return questionArray
  }

  class func isWrongAnswer(questionArray: [Question], currentQuestionNumber: Int, backNumber: Int, numberText: String) -> Bool {
    if numberText.toInt() != questionArray[currentQuestionNumber - backNumber - 1].answer {
      return true
    } else {
      return false
    }
  }

  override init() {
    // 式の答えを決める
    self.answer = Int.getRandomInt(10)
    
    // 演算子を決める
    let operatorArray = ["+","-","×","÷"]
    self.operatorSymbol = operatorArray[Int.getRandomInt(4)]
    
    // 演算子と答えに応じて各項を決める
    switch self.operatorSymbol {
      case "+": // 足し算の場合、各項は答え以下の整数
        self.firstItem = Int.getRandomInt(self.answer + 1)
        self.secondItem = self.answer - self.firstItem
      case "-": // 引き算の場合、第一項は答え以上の整数（ここでは答え+10を最大値とする）
        self.firstItem = self.answer + Int.getRandomInt(11)
        self.secondItem = self.firstItem - self.answer
      case "×": // 掛け算の場合、それぞれの項は答えの約数。答えが0の場合はどちらかの項を0にし、もう一方を適当に決める。
        if self.answer == 0 {
          var itemA = 0
          var itemB = Int.getRandomInt(20)
          if Int.getRandomInt(2) == 0 {
            var temp = itemA
            itemA = itemB
            itemB = temp
          }
          self.firstItem = itemA
          self.secondItem = itemB
        } else {
          self.firstItem = self.answer.returnRandomDivisoraFactor()
          self.secondItem = self.answer / self.firstItem
        }
      case "÷": // 割り算の場合、それぞれの項が20未満になるよう適当に選ぶ。
        if self.answer == 0 {
          self.firstItem = 0
          self.secondItem = Int.getRandomInt(19) + 1
        } else {
          self.secondItem = Int.getRandomInt(19 / self.answer) + 1
          self.firstItem = self.secondItem * self.answer
        }
      default: // 実行されることは無いが、各プロパティをセットしないと、initiallizeされていないと怒られてしまう
        self.firstItem = 0
        self.secondItem = 0
    }
  }
}
