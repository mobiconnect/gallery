//
//  ViewController.swift
//  Aotomot
//
//  Created by AOTOMOT on 4/7/18.
//  Copyright © 2018 Aotomot. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {
  
  @IBOutlet weak var viewLogo: UIView!
  @IBOutlet weak var imgLogo: UIImageView!
  @IBOutlet weak var topConstraintLogoView: NSLayoutConstraint!
  
  override func viewDidLoad() {
    // Hide the status bar on splash screen
    super.viewDidLoad()

    self.topConstraintLogoView.constant = UIScreen.main.bounds.size.height/2-self.viewLogo.frame.height/2
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if let appDelegate = AppDelegate.shared(){
      appDelegate.changeRootViewControllerWithIdentifier(identifier: "galleryNav", storyBoard: "Gallery")
    }
  }
  
}


