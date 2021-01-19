//
//  ContentDetailViewController.swift
//  Mobiconnect_iOS
//
//  Created by Mobiddiction on 12/9/17.
//  Copyright © 2017 Mobiddiction. All rights reserved.
//

import UIKit

class ContentDetailViewController: UIViewController {
  
  @IBOutlet weak var moreInfoBottomAlign: NSLayoutConstraint!
  @IBOutlet weak var btnCallToAction: UIButton!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var btnYtRightConstraint: NSLayoutConstraint!
  @IBOutlet weak var navBarHeight: NSLayoutConstraint!
  @IBOutlet weak var navBarContainerView: UIView!
  var header : StreachyImageCarouselView!
  var newsInfo:News?
  var options: String = "fullScreenTop"
  let kImageHeight:CGFloat = 380.0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.contentInsetAdjustmentBehavior = .never

    self.btnCallToAction.backgroundColor = UIColor(hex: "#E31349")
    self.btnCallToAction.setTitleColor( UIColor(hex: "#444444"), for: .normal)
    navBarContainerView.backgroundColor = UIColor(hex: "#F7F9F8")
    if let news = newsInfo{
      self.moreInfoBottomAlign.constant = news.moreInfo != nil ? 0.0 : -60.0
      self.btnCallToAction.setTitle(news.moreInfoButtonText, for: .normal)
      self.btnYtRightConstraint.constant = news.youtubeUrl != nil ? 15.0 : -60.0      
      self.setupHeaderView()
    }
  }
  
  @IBAction func openMoreInfo(_ sender: UIButton) {
    if self.newsInfo?.moreInfo != nil{
      UIApplication.shared.open(self.newsInfo!.moreInfo!, options: [:], completionHandler: {success in
        print("Open app url success: \(success)")
      })
    }
  }
  
  @IBAction func openYoutubeInfo(_ sender: UIButton) {
    if self.newsInfo?.youtubeUrl != nil{
      UIApplication.shared.open(self.newsInfo!.youtubeUrl!, options: [:], completionHandler: {success in
        print("Open app url success: \(success)")
      })
    }
  }

  func setupHeaderView() {
    if newsInfo != nil
      && (newsInfo?.headerImage != nil){
      var imageUrls:[String] = []
      for image in newsInfo!.images{
        imageUrls.append(image.absoluteString)
      }
      if imageUrls.count == 0{
        if let url = newsInfo?.headerImage?.absoluteString{
          imageUrls.append(url)
        }
      }
      navBarContainerView.alpha = 0.0
      header = StreachyImageCarouselView()
      header.stretchHeaderSize(headerSize: CGSize(width: view.frame.size.width, height: kImageHeight), controller: self, images: imageUrls)
      self.tableView.tableHeaderView = header
    }else{
      let headerView=UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: navBarHeight.constant))
      self.tableView.tableHeaderView = headerView
    }
  }
  
  @IBAction func backpressed(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }

  
  // MARK: - ScrollView Delegate
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if newsInfo != nil
      && newsInfo?.headerImage != nil{
      header.updateScrollViewOffset(scrollView)
      
      // NavigationHeader alpha update
      let offset : CGFloat = scrollView.contentOffset.y
      if (offset > kImageHeight-navBarHeight.constant) {
        let alpha : CGFloat = min(CGFloat(1), CGFloat(1) - (CGFloat(kImageHeight-navBarHeight.constant) + (navBarHeight.constant) - offset) / (navBarHeight.constant))
        navBarContainerView.alpha = CGFloat(alpha)
      } else {
        navBarContainerView.alpha = 0.0;
      }
    }
  }
}

extension ContentDetailViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView=UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0.0))
    headerView.backgroundColor = UIColor.clear
    return headerView
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 0.0
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let headerView=UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0.0))
    headerView.backgroundColor = UIColor.clear
    return headerView
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.0
  }
}

extension ContentDetailViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if self.options == "fullScreenTop"{
      let cell=tableView.dequeueReusableCell(withIdentifier: "StreachyNewsDetailCell", for: indexPath) as! StreachyNewsDetailCell
      if self.newsInfo != nil{
        cell.updateData(self.newsInfo!)
      }
      cell.selectionStyle = .none
      return cell
    }else{
      let cell=tableView.dequeueReusableCell(withIdentifier: "NewsDetailCell", for: indexPath) as! NewsDetailCell
      if self.newsInfo != nil{
        cell.updateData(self.newsInfo!)
        if newsInfo!.images.count > 0{
          cell.configureCell(images:self.newsInfo!.images)
          cell.bannerHeight.constant = 200.0
          cell.gradientView.isHidden = false
        }else{
          cell.bannerHeight.constant = 0.0
          cell.gradientView.isHidden = true
        }
      }
      cell.selectionStyle = .none
      return cell
    }
  }  
}

