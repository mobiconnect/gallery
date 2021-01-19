//
//  StreachyImageCarouselView.swift
//  Mobiconnect_iOS
//
//  Created by Mobiddiction on 20/9/17.
//  Copyright © 2017 Mobiddiction. All rights reserved.
//

import UIKit
import SDCycleScrollView
import SnapKit

open class StreachyImageCarouselView: UIView {
    
    fileprivate var contentSize = CGSize.zero
    fileprivate var topInset : CGFloat = 0
    var imageScrollView: SDCycleScrollView!

    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public
    open func stretchHeaderSize(headerSize: CGSize, controller: UIViewController, images: [String]) {
        imageScrollView = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: headerSize.width, height: headerSize.height), shouldInfiniteLoop: false, imageNamesGroup: images)
        imageScrollView?.pageDotColor = UIColor(hex: "#F7F9F8")
        imageScrollView?.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated
        imageScrollView?.pageControlDotSize = CGSize(width: 6.0, height: 6.0)
        imageScrollView?.currentPageDotColor = UIColor(hex: "#E31349")
      imageScrollView?.backgroundColor = UIColor.clear
        imageScrollView?.autoScroll = true
        self.addSubview(imageScrollView!)
        imageScrollView?.snp.makeConstraints { (make) -> Void in
          make.edges.equalTo(self).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
      imageScrollView?.bannerImageViewContentMode=UIView.ContentMode.scaleAspectFill
        contentSize = headerSize
        self.frame = CGRect(x: 0, y: 0, width: headerSize.width, height: headerSize.height)
    }
    
    open func updateScrollViewOffset(_ scrollView: UIScrollView) {
        
        if imageScrollView == nil { return }
        var scrollOffset : CGFloat = scrollView.contentOffset.y
        scrollOffset += topInset
        
        if scrollOffset < 0 {
            imageScrollView.frame = CGRect(x: 0 ,y: scrollOffset, width: contentSize.width , height: contentSize.height - scrollOffset);
        } else {
            imageScrollView.frame = CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height);
        }
    }
}

