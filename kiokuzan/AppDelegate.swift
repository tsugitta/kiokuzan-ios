//
//  AppDelegate.swift
//  kiokuzan
//
//  Created by sdklt on 2015/07/04.
//  Copyright (c) 2015年 sdklt. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // ▼ 1. windowの背景色にLaunchScreen.xibのviewの背景色と同じ色を設定
    self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
    self.window!.backgroundColor = UIColor(red: 230/255, green: 240/255, blue: 255/255, alpha: 1)
    self.window!.makeKeyAndVisible()
    
    // ▼ 2. rootViewControllerをStoryBoardから設定 (今回はUItopViewControllerとしているが、他のViewControllerでも可)
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var topViewController = mainStoryboard.instantiateViewControllerWithIdentifier("TopViewController") as! UIViewController
    self.window!.rootViewController = topViewController
    
    // ▼ 3. rootViewController.viewをロゴ画像の形にマスクし、LaunchScreen.xibのロゴ画像と同サイズ・同位置に配置
    topViewController.view.layer.mask = CALayer()
    topViewController.view.layer.mask.contents = UIImage(named: "idea-1000")!.CGImage
    topViewController.view.layer.mask.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
    topViewController.view.layer.mask.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    topViewController.view.layer.mask.position = CGPoint(x: topViewController.view.frame.width / 2, y: topViewController.view.frame.height / 2)
    
    // ▼ 4. rootViewController.viewの最前面に白いviewを配置
    var maskBgView = UIView(frame: topViewController.view.frame)
    maskBgView.backgroundColor = UIColor.whiteColor()
    topViewController.view.addSubview(maskBgView)
    topViewController.view.bringSubviewToFront(maskBgView)
    
    // ▼ 5. rootViewController.viewのマスクを少し縮小してから、画面サイズよりも大きくなるよう拡大するアニメーション
    let transformAnimation = CAKeyframeAnimation(keyPath: "bounds")
    transformAnimation.delegate = self
    transformAnimation.duration = 1
    transformAnimation.beginTime = CACurrentMediaTime() + 1 // 開始タイミングを1秒遅らせる
    let initalBounds = NSValue(CGRect: topViewController.view.layer.mask.bounds)
    let secondBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 50, height: 50))
    let finalBounds = NSValue(CGRect: CGRect(x: 0, y: 0, width: 2000, height: 2000))
    transformAnimation.values = [initalBounds, secondBounds, finalBounds]
    transformAnimation.keyTimes = [0, 0.5, 1]
    transformAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
    transformAnimation.removedOnCompletion = false
    transformAnimation.fillMode = kCAFillModeForwards
    topViewController.view.layer.mask.addAnimation(transformAnimation, forKey: "maskAnimation")
    
    // ▼ 6. rootViewController.viewの最前面に配置した白いviewを透化するアニメーション (完了後に親viewから削除)
    UIView.animateWithDuration(0.1,
      delay: 1.35,
      options: UIViewAnimationOptions.CurveEaseIn,
      animations: {
        maskBgView.alpha = 0.0
      },
      completion: { finished in
        maskBgView.removeFromSuperview()
    })
    
    // ▼ 7. rootViewController.viewを少し拡大して元に戻すアニメーション
    UIView.animateWithDuration(0.25,
      delay: 1.3,
      options: UIViewAnimationOptions.TransitionNone,
      animations: {
        self.window!.rootViewController!.view.transform = CGAffineTransformMakeScale(1.05, 1.05)
      },
      completion: { finished in
        UIView.animateWithDuration(0.3,
          delay: 0.0,
          options: UIViewAnimationOptions.CurveEaseInOut,
          animations: {
            self.window!.rootViewController!.view.transform = CGAffineTransformIdentity
          },
          completion: nil
        )
    })
    
    return true
  }
  
  // ▼ 8. 「5.」のアニメーション完了時のdelegateメソッドを実装し、マスクを削除する
  override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
    // remove mask when animation completes
    self.window!.rootViewController!.view.layer.mask = nil
  }
  

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

