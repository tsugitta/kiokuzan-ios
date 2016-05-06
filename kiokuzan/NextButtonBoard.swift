//
//  NextButtonBoard.swift
//  kiokuzan
//
//  Created by sdklt on 2015/07/07.
//  Copyright (c) 2015年 sdklt. All rights reserved.
//

import UIKit

protocol NextButtonBoardDelegate {
    func pushedNext()
}

class NextButtonBoard: UIView {
    var delegate: NextButtonBoardDelegate?

    init(screenWidth: Double, screenHeight: Double, viewHeight: Double) {
        super.init(frame: CGRect(x: 0, y: screenHeight - viewHeight, width: screenWidth, height: viewHeight))

        var button = CustomButton()
        var buttonWidth = screenWidth / 2
        var buttonHeight = viewHeight / 4
        var buttonPositionX = (screenWidth - buttonWidth) / 2
        var buttonPositionY = (viewHeight - buttonHeight) * 2 / 3
        button.frame = CGRect(x:buttonPositionX, y:buttonPositionY, width:buttonWidth, height:buttonHeight)

        button.layer.borderColor = UIColor.pastelBlueColor(0.5).CGColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5

        button.setTitle("Next", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.pastelBlueColor(0.5), forState: UIControlState.Normal)

        button.addTarget(self, action: "buttonTapped:", forControlEvents: UIControlEvents.TouchUpInside)

        self.addSubview(button)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buttonTapped(sender: UIButton) {
        self.delegate?.pushedNext()
    }
}
