//
//  PlayViewController.swift
//  kiokuzan
//
//  Created by sdklt on 2015/07/04.
//  Copyright (c) 2015年 sdklt. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController, NextButtonBoardDelegate, InputBoardDelegate {
  let screenWidth: Double = Double(UIScreen.mainScreen().bounds.size.width) // 画面の横幅
  let screenHeight: Double = Double(UIScreen.mainScreen().bounds.size.height) // 画面の縦
  let statusBarHeight: Double = Double(UIApplication.sharedApplication().statusBarFrame.height)
  let inputHeight: Double = 300.0 // どのデバイスでも入力フォームの高さは同じに
  
  var nextButtonBoard: NextButtonBoard!
  var inputBoard: InputBoard!
  var questionView: UIView!
  var timerLabel: UILabel!
  var questionNumberLabel: UILabel!
  var questionLabel: LTMorphingLabel!
  var answerNumberLabel: UILabel!
  
  var questionArray: [Question] = []
  var totalQuestionNumber: Int!
  var backNumber: Int!
  var currentQuestionNumber: Int = 0
  var currentAnswerNumber: Int = 0
  var missCount: Int = 0
  
  var timerCountNum: Int = 0
  var timer = NSTimer()
  var missPenaltySecond = 10
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // 各ビューをセット
    self.nextButtonBoard = NextButtonBoard(screenWidth: self.screenWidth, screenHeight: self.screenHeight, viewHeight: self.inputHeight)
    self.nextButtonBoard.delegate = self
    self.inputBoard = InputBoard(screenWidth: self.screenWidth, screenHeight: self.screenHeight, viewHeight: self.inputHeight)
    self.inputBoard.delegate = self
    self.questionView = UINib(nibName: "QuestionView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
    self.timerLabel = self.questionView.viewWithTag(1) as! UILabel
    self.questionNumberLabel = self.questionView.viewWithTag(2) as! UILabel
    self.questionLabel = self.questionView.viewWithTag(3) as! LTMorphingLabel
    self.answerNumberLabel = self.questionView.viewWithTag(4) as! UILabel
    self.questionLabel.text = ""
    self.questionLabel.morphingEffect = .Evaporate

    // 問題作成
    switch self.backNumber {
      case 3:
        totalQuestionNumber = 20
      case 5:
        totalQuestionNumber = 25
      case 10:
        totalQuestionNumber = 30
      default:
        break
    }
    questionArray = Question.generateQuestionArray(numberOfQuestions: self.totalQuestionNumber)

    // 問題表示
    self.questionView.frame = CGRect(x: 0, y: self.statusBarHeight, width: self.screenWidth, height: self.screenHeight - self.inputHeight - self.statusBarHeight)
    self.view.addSubview(questionView)
    updateQuestion()
    
    // 「Next」ボタン
    self.view.addSubview(self.nextButtonBoard)
    
    // 「Back」ボタン
    var backButton = (self.questionView.viewWithTag(5) as! UIButton)
    backButton.addTarget(self, action: "backButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
    
    // タイマー始動
    timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
  }

  func updateQuestion() {
    currentQuestionNumber++
    if currentQuestionNumber > backNumber {
      if currentAnswerNumber + 1 > totalQuestionNumber {
        timer.invalidate()
        performSegueWithIdentifier("fromPlayToResultSegue",sender: nil)
      } else {
        currentAnswerNumber++
      }
    }
    updateQuestionView()
  }
  
  func updateQuestionView() {
    if self.currentQuestionNumber <= self.totalQuestionNumber {
      var currentQuestion = self.questionArray[self.currentQuestionNumber - 1]
      self.questionNumberLabel.text = "Q\(self.currentQuestionNumber)"
      self.questionLabel.text = "\(currentQuestion.firstItem) \(currentQuestion.operatorSymbol) \(currentQuestion.secondItem) = ?"
    } else {
      self.questionNumberLabel.text = ""
      self.questionLabel.text = "Hang in there!"
    }
    if self.currentAnswerNumber > 0 {
      self.answerNumberLabel.text = "Answer Q\(self.currentAnswerNumber)."
    } else {
      self.answerNumberLabel.text = ""
    }
  }
  
  func checkAnswer(numberText: String) {
    if numberText == "Path" {
      self.missCount++
      self.timerCountNum += self.missPenaltySecond * 100
    } else {
      var inputNumber = numberText.toInt()
      if self.questionArray[self.currentQuestionNumber - self.backNumber - 1].answer != inputNumber {
        self.missCount++
        self.timerCountNum += self.missPenaltySecond * 100
      }
    }
  }
  
  func pushedNext() {
    updateQuestion()
    if currentQuestionNumber > backNumber {
      self.nextButtonBoard.removeFromSuperview()
      self.view.addSubview(self.inputBoard)
    }
  }

  func pushedNumber(numberText: String) {
    checkAnswer(numberText)
    updateQuestion()
  }
  
  func backButtonTapped(sender: UIButton){
    self.performSegueWithIdentifier("fromPlayToTopSegue", sender: self)
  }
  
  func updateTimer() {
    timerCountNum++
    timeFormat(timerCountNum)
  }
  
  func timeFormat(countNum: Int) {
    let ms = countNum % 100
    let s = (countNum - ms) / 100 % 60
    let m = (countNum - s - ms) / 6000 % 3600
    self.timerLabel.text = String(format: "%02d:%02d.%02d", m, s, ms)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    if segue.identifier == "fromPlayToResultSegue" {
      var resultView :ResultViewController = segue.destinationViewController as! ResultViewController
      resultView.timerCountNum = self.timerCountNum
      resultView.missCount = self.missCount
      resultView.backNumber = self.backNumber
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
