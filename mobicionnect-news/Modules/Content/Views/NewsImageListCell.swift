//
//  NewsImageListCell.swift
//  Mobiconnect_iOS
//
//  Created by Mobiddiction on 26/4/18.
//  Copyright © 2018 Mobiddiction. All rights reserved.
//

import UIKit
import SDWebImage

class NewsImageListCell: UITableViewCell {

    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var imgHero: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var descriptionView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.containerView.layer.cornerRadius = 4.0
      self.imgHero.backgroundColor = UIColor(hex: "#E31349").withAlphaComponent(0.5)
        self.contentView.backgroundColor = UIColor(hex: "#F7F9F8")
    }
    
    func configureCell(_ contentInfo:News){
        self.lbTitle.attributedText = Utility.convertStrToDescAttriuteStr(contentInfo.name)
        
        if let url = contentInfo.headerImage{
          self.imgHero.sd_setImage(with:url, placeholderImage:nil, options: .avoidAutoSetImage, completed: { (image, _, type, _) -> Void in
                if (image != nil) {
                    if (type == SDImageCacheType.none || type == SDImageCacheType.disk) {
                      UIView.transition(with: self.imgHero,
                                        duration: 0.75,
                                        options: .transitionCrossDissolve,
                                        animations: {
                            self.imgHero.image = image
                            self.imgHero.backgroundColor = UIColor.clear
                        }, completion: nil)
                    } else {
                        self.imgHero.image = image
                        self.imgHero.backgroundColor = UIColor.clear
                    }
                }else{
                    self.imgHero.backgroundColor = UIColor(hex: "#E31349").withAlphaComponent(0.5)
                }
            })
        }
        
      self.lbTime.text = contentInfo.newsDate?.localDateString("h:mma")
      self.lbDate.text = contentInfo.newsDate?.localDateString()
    }
    
}
