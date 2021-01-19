//
//  StreachyNewsDetailCell.swift
//  Mobiconnect_iOS
//
//  Created by Mobiddiction on 20/9/17.
//  Copyright © 2017 Mobiddiction. All rights reserved.
//

import UIKit

class StreachyNewsDetailCell: UITableViewCell {

    @IBOutlet weak var longDescription: UITextView!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    var newsInfo:News?
  
    func updateData(_ newsInfo: News) {
        self.newsInfo = newsInfo
        self.btnShare.isHidden = false
        self.longDescription.attributedText = Utility.convertStrToDescAttriuteStr(newsInfo.longDescription)
        self.lbTitle.text = newsInfo.name
        if newsInfo.newsDate != nil{
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mma"
            let time = formatter.string(from: newsInfo.newsDate!)
            self.lbTime.text = time
            self.lbDate.text = newsInfo.newsDate?.localDateString()
        }
    }


    @IBAction func shareNews(_ sender: UIButton) {
      if let name = self.newsInfo?.name{
        let shareString = "\(name)\n\n\(self.newsInfo?.shortDescription ?? (""))"
        let objectsToShare = [shareString] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
        activityVC.popoverPresentationController?.sourceView = sender
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        rootViewController?.present(activityVC, animated: true, completion: nil)
      }
    }

}
