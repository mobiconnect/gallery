//
//  NewsListCell.swift
//  Mobiconnect_iOS
//
//  Created by Mobiddiction on 12/9/17.
//  Copyright © 2017 Mobiddiction. All rights reserved.
//

import UIKit
import SDWebImage

class NewsListCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var imgThumnail: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgThumnail.layer.cornerRadius = 4.0
      self.contentView.backgroundColor = UIColor(hex: "#F7F9F8")
      lbTitle.textColor = UIColor(hex: "#444444")
      lbDescription.textColor = UIColor(hex: "#9B9B9B")
    }

    func updateData(_ newsInfo: News) {
      self.lbTitle.text = newsInfo.name
      self.lbDescription.text = newsInfo.shortDescription
      
      if let url = newsInfo.headerImage{
        self.imgThumnail.sd_setImage(with: url, placeholderImage:nil, options: .avoidAutoSetImage, completed: { (image, _, type, _) -> Void in
          if (image != nil) {
            if (type == SDImageCacheType.none || type == SDImageCacheType.disk) {
              UIView.transition(with: self.imgThumnail, duration: 0.75, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
                self.imgThumnail.image = image
                self.imgThumnail.backgroundColor = UIColor.clear
              }, completion: nil)
            } else {
              self.imgThumnail.image = image
              self.imgThumnail.backgroundColor = UIColor.clear
            }
          }else{
            self.imgThumnail.backgroundColor = UIColor(hex: "#E31349").withAlphaComponent(0.5)
          }
        })
      }
    }
}
