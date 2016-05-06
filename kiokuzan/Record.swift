//
//  Record.swift
//  kiokuzan
//
//  Created by sdklt on 2015/07/10.
//  Copyright (c) 2015年 sdklt. All rights reserved.
//

import UIKit

class Record: NSObject {
    let name: String
    let scoreTime: String

    init(name: String, score: Int) {
        self.name = name
        self.scoreTime = score.convertToStringTimeForRanking()
    }
}
