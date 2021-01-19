//
//  NewsDetailCell.swift
//  Mobiconnect_iOS
//
//  Created by Mobiddiction on 12/9/17.
//  Copyright © 2017 Mobiddiction. All rights reserved.
//

import UIKit
import SDCycleScrollView

class NewsDetailCell: UITableViewCell {

    @IBOutlet weak var bannerContainerView: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var longDescription: UITextView!
    @IBOutlet weak var bannerHeight: NSLayoutConstraint!
    @IBOutlet weak var gradientView: UIImageView!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    var imageScrollView: SDCycleScrollView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateData(_ newsInfo: News) {
        self.lbTitle.text = newsInfo.name
        self.longDescription.attributedText = Utility.convertStrToDescAttriuteStr(newsInfo.longDescription)
        
        if newsInfo.newsDate != nil{
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"
            let time = formatter.string(from: newsInfo.newsDate!)
            self.lbTime.text = time
            self.lbDate.text = newsInfo.newsDate?.localDateString()
        }
    }

    func configureCell(images:[URL]){
      var imageUrls:[String] = []
      for image in images{
        imageUrls.append(image.absoluteString)
      }

        imageScrollView = SDCycleScrollView(frame: self.bannerContainerView.frame, shouldInfiniteLoop: true, imageNamesGroup: imageUrls)
        imageScrollView.autoScroll = images.count > 1
        imageScrollView?.pageDotColor = UIColor(hex: "#F7F9F8")
        imageScrollView?.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated
        imageScrollView?.pageControlDotSize = CGSize(width: 6.0, height: 6.0)
        imageScrollView?.currentPageDotColor = UIColor(hex: "#E31349")
        imageScrollView?.backgroundColor = UIColor.clear
        self.bannerContainerView.addSubview(imageScrollView!)
        imageScrollView?.snp.makeConstraints { (make) -> Void in
          make.edges.equalTo(self.bannerContainerView).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
      imageScrollView?.bannerImageViewContentMode=UIView.ContentMode.scaleAspectFill
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
