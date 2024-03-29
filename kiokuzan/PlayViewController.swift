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
    var inputHeight: Double!

    var coverView: UIView!
    var nextButtonBoard: NextButtonBoard!
    var inputBoard: InputBoard!
    var questionView: UIView!
    var timerLabel: UILabel!
    var questionNumberLabel: UILabel!
    var questionLabel: LTMorphingLabel!
    var answerNumberLabel: UILabel!
    var hangInThereLabel: UILabel!

    var questionArray: [Question] = []
    var numberOfQuestions: Int!
    var backNumber: Int!
    var currentQuestionNumber: Int = 0
    var currentAnswerNumber: Int = 0
    var missCount: Int = 0

    var timerCountNum: Int = 0
    var timer = NSTimer()
    var missPenaltySecond = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        println(self.statusBarHeight)
        // 正誤判定UIView
        self.coverView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        self.coverView.userInteractionEnabled = false
        self.coverView.alpha = 0.0
        self.coverView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(coverView)

        // 各ビューをセット
        self.changeInputHeight()
        self.nextButtonBoard = NextButtonBoard(screenWidth: self.screenWidth, screenHeight: self.screenHeight, viewHeight: self.inputHeight)
        self.nextButtonBoard.delegate = self
        self.inputBoard = InputBoard(screenWidth: self.screenWidth, screenHeight: self.screenHeight, viewHeight: self.inputHeight)
        self.inputBoard.delegate = self
        self.questionView = UINib(nibName: "QuestionView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
        self.timerLabel = self.questionView.viewWithTag(1) as! UILabel
        self.questionNumberLabel = self.questionView.viewWithTag(2) as! UILabel
        self.questionLabel = self.questionView.viewWithTag(3) as! LTMorphingLabel
        self.answerNumberLabel = self.questionView.viewWithTag(4) as! UILabel
        self.hangInThereLabel = self.questionView.viewWithTag(6) as! UILabel
        self.questionLabel.text = ""
        self.questionLabel.morphingEffect = .Evaporate

        // 問題作成
        self.numberOfQuestions = Question.returnNumberOfQuestions(self.backNumber)
        questionArray = Question.generateQuestionArray(self.numberOfQuestions)

        // 問題表示
        self.questionView.frame = CGRect(x: 0, y: self.statusBarHeight, width: self.screenWidth, height: self.screenHeight - self.inputHeight - self.statusBarHeight)
        self.questionView.backgroundColor = UIColor.clearColor()
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
        self.currentQuestionNumber++
        if self.currentQuestionNumber > self.backNumber {
            if self.currentAnswerNumber + 1 > self.numberOfQuestions {
                timer.invalidate()
                performSegueWithIdentifier("fromPlayToResultSegue",sender: nil)
            } else {
                self.currentAnswerNumber++
            }
        }
        self.updateQuestionView()
    }

    func updateQuestionView() {
        if self.currentQuestionNumber <= self.numberOfQuestions {
            var currentQuestion = self.questionArray[self.currentQuestionNumber - 1]
            self.questionNumberLabel.text = "Q\(self.currentQuestionNumber)"
            self.questionLabel.text = "\(currentQuestion.firstItem) \(currentQuestion.operatorSymbol) \(currentQuestion.secondItem) = ?"
        } else {
            self.questionNumberLabel.text = ""
            self.questionLabel.removeFromSuperview()
            self.showHangInThereLabel()
        }
        if self.currentAnswerNumber > 0 {
            self.answerNumberLabel.text = "Answer Q\(self.currentAnswerNumber)."
        } else {
            self.answerNumberLabel.text = ""
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
        if Question.isWrongAnswer(self.questionArray, currentQuestionNumber: self.currentQuestionNumber, backNumber: self.backNumber, numberText: numberText) {
            self.missCount++
            self.timerCountNum += self.missPenaltySecond * 100
            self.changeCoverView(UIColor.pastelLightRedColor(1))
            self.showPenaltySecond()
        }
        updateQuestion()
    }

    func changeCoverView(color: UIColor) {
        UIView.animateWithDuration(0.4,
                                   delay: 0,
                                   options: UIViewAnimationOptions.CurveEaseIn,
                                   animations: {
                                    self.coverView.alpha = 1
                                    self.coverView.backgroundColor = color
            },
                                   completion: nil
        )
        UIView.animateWithDuration(0.4,
                                   delay: 0,
                                   options: UIViewAnimationOptions.CurveEaseIn,
                                   animations: {
                                    self.coverView.alpha = 0.0
                                    self.coverView.backgroundColor = UIColor.whiteColor()
            },
                                   completion: nil
        )
    }

    func showPenaltySecond() {
        var label = UILabel()
        label.text = "+10sec"
        label.textColor = UIColor.pastelBlueColor(1)
        label.font = UIFont(name: ".HelveticaNeueInterface-UltraLightP2", size: 23.0)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.questionView.addSubview(label)
        var topConstraint = NSLayoutConstraint(item: label, attribute: .Top, relatedBy: NSLayoutRelation.Equal, toItem: self.questionView, attribute: .Top, multiplier: 1, constant: 10)
        var leftConstraint = NSLayoutConstraint(item: label, attribute: .Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.timerLabel, attribute: .Trailing, multiplier: 1, constant: 5)
        self.questionView.addConstraints([topConstraint, leftConstraint])
        self.view.layoutIfNeeded()
        leftConstraint.constant += 50
        UIView.animateWithDuration(0.5,
                                   delay: 0.1,
                                   options: UIViewAnimationOptions.CurveEaseIn,
                                   animations: {
                                    label.alpha = 0
                                    self.view.layoutIfNeeded()
            },
                                   completion: { finished in
                                    var constraints = self.questionView.constraints()
                                    for i in 1...2 {
                                        constraints.removeLast()
                                    }
                                    label.removeFromSuperview()
        })
    }

    func backButtonTapped(sender: UIButton) {
        self.performSegueWithIdentifier("fromPlayToTopSegue", sender: self)
    }

    func updateTimer() {
        self.timerCountNum++
        self.timerLabel.text = timerCountNum.convertToStringTime()
    }

    func changeInputHeight() {
        switch self.screenWidth {
        case 480:
            self.inputHeight = 390
        default:
            self.inputHeight = 260
        }
    }

    func showHangInThereLabel() {
        UIView.animateWithDuration(0.3,
                                   delay: 0,
                                   options: UIViewAnimationOptions.CurveEaseIn,
                                   animations: {
                                    self.hangInThereLabel.alpha = 1
            },
                                   completion: nil
        )
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "fromPlayToResultSegue" {
            var resultView: ResultViewController = segue.destinationViewController as! ResultViewController
            resultView.timerCountNum = self.timerCountNum
            resultView.missCount = self.missCount
            resultView.backNumber = self.backNumber
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
