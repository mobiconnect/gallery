//
//  AppDelegate.swift
//  Mobiconnect
//
//  Created by Mobiconnect on 4/7/18.
//  Copyright © 2018 Mobiconnect. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?

  class func shared() -> AppDelegate? {
    return UIApplication.shared.delegate as? AppDelegate;
  }
  
  func changeRootViewControllerWithIdentifier(identifier:String!, storyBoard:String!,animate:Bool=false,options: UIView.AnimationOptions = .transitionCrossDissolve) {
    let storyboard = UIStoryboard(name: storyBoard, bundle: nil)
    let desiredViewController = storyboard.instantiateViewController(withIdentifier: identifier);
    self.window?.switchRootViewController(desiredViewController,animated: animate,options:options)
  }
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    // Global settings
    return true
  }
}


