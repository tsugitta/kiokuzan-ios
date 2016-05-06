//
//  ViewController.swift
//  kiokuzan
//
//  Created by sdklt on 2015/07/04.
//  Copyright (c) 2015年 sdklt. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberOfQuestions: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var marginBottomOfTitle: NSLayoutConstraint!
    @IBOutlet weak var marginTopOfBackNumber: NSLayoutConstraint!
    @IBOutlet weak var marginTopOfNumberOfQuestions: NSLayoutConstraint!
    @IBOutlet weak var marginTopOfStartButton: NSLayoutConstraint!
    var logoImageView: UIImageView!
    var backNumber = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeConstraint()

        // 文字間隔調整
        let attributedText = NSMutableAttributedString(string: "kiokuzan")
        let customLetterSpacing = 4.5
        attributedText.addAttribute(NSKernAttributeName, value: customLetterSpacing, range: NSMakeRange(0, attributedText.length))
        titleLabel.attributedText = attributedText
    }

    override func viewWillAppear(animated: Bool) {
        showHighScore(self.backNumber)
    }

    func showHighScore(backNumber: Int) {
        let defaults = NSUserDefaults.standardUserDefaults()
        var highScoreCountNum: AnyObject! = defaults.objectForKey("\(backNumber)BackHighScoreCountNum")
        if highScoreCountNum != nil {
            highScoreLabel.text = "High Score \((highScoreCountNum as! Int).convertToStringTime())"
        } else {
            highScoreLabel.text = ""
        }
    }

    @IBAction func backNumberChange(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.backNumber = 3
            self.numberOfQuestions.text = "20 questions"
        case 1:
            self.backNumber = 5
            self.numberOfQuestions.text = "25 questions"
        case 2:
            self.backNumber = 10
            self.numberOfQuestions.text = "30 questions"
        default:
            break
        }
        showHighScore(backNumber)
    }

    func changeConstraint() {
        switch Double(UIScreen.mainScreen().bounds.size.height) {
        case 480:
            self.marginBottomOfTitle.constant = 70
            self.marginTopOfBackNumber.constant = 15
            self.marginTopOfNumberOfQuestions.constant = 15
            self.marginTopOfStartButton.constant = 15
        case 568:
            self.marginBottomOfTitle.constant = 120
            self.marginTopOfBackNumber.constant = 25
            self.marginTopOfNumberOfQuestions.constant = 25
            self.marginTopOfStartButton.constant = 25
        default:
            break
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "fromTopToStartCountDownSegue" {
            var startCountDownView: StartCountDownViewController = segue.destinationViewController as! StartCountDownViewController
            startCountDownView.backNumber = self.backNumber
        }
    }

    @IBAction func unwindToTop(segue: UIStoryboardSegue) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
