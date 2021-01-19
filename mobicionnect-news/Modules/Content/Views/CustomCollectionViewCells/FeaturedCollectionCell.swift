//
//  FeaturedCollectionCell.swift
//  Mobiconnect_iOS
//
//  Created by Mobiddiction on 12/9/17.
//  Copyright © 2017 Mobiddiction. All rights reserved.
//

import UIKit
import SDWebImage

class FeaturedCollectionCell: UICollectionViewCell {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var imgHero: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lbTitle.font = UIFont(name: "SourceSansPro-Light", size: 16.0)!
        self.contentView.backgroundColor = UIColor(hex: "#F7F9F8")
        self.containerView.backgroundColor = UIColor(hex: "#F7F9F8")
        self.containerView.layer.cornerRadius = 4.0
    }

    func updateData(newsInfo: News) {
        addShadow()
        self.lbTitle.text = newsInfo.name
      if let url = newsInfo.headerImage{
        self.imgHero.sd_setImage(with:url, placeholderImage: nil, options: .avoidAutoSetImage, completed: { (image, _, type, _) -> Void in
          if (image != nil) {
            if (type == SDImageCacheType.none || type == SDImageCacheType.disk) {
              UIView.transition(with: self.imgHero, duration: 0.75, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
                self.imgHero.image = image
              }, completion: nil)
            } else {
              self.imgHero.image = image
            }
          }
        })
      }
      self.lbTime.text = newsInfo.newsDate?.localDateString()
      self.lbDate.text = newsInfo.newsDate?.localDateString()
    }
}
