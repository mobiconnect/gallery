//
//  Utility.swift
//  Aotomot
//
//  Created by AOTOMOT on 4/7/18.
//  Copyright © 2018 Aotomot. All rights reserved.
//

import UIKit
import SystemConfiguration

class Utility {

    class func convertStrToAttriuteStr(_ str:String,lineSpace:CGFloat=2.0,colour:UIColor=UIColor(hex: "#444444"),size:CGFloat=16.0)->NSAttributedString{
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = CGFloat(lineSpace)
        paragraphStyle.alignment=NSTextAlignment.left
        let attributes:[NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : UIFont(name: "SourceSansPro-Regular", size: size)!,
            NSAttributedString.Key.foregroundColor : colour,
            NSAttributedString.Key.paragraphStyle:paragraphStyle,
            NSAttributedString.Key.kern: CGFloat(0.5),
            ]
        let attrString = NSAttributedString(
            string: str,
            attributes: attributes)
        return attrString
    }

  class func showAlert(_ title: String="", message: String,buttonTitle: String="Ok".capitalized, okAction:@escaping () -> Void = {
        }) {
        if let controller = UIApplication.topViewController(){
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.view.tintColor = UIColor(hex: "#E31349")
            alert.view.layer.cornerRadius = 4.0
            alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: {(_:UIAlertAction!) in
                okAction()
            }))
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                controller.present(alert, animated: true, completion: nil)
            }
        }
    }
}
