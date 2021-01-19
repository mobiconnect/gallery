//
//  Content.swift
//  Mobiconnect
//
//  Created by Mobiconnect on 13/6/19.
//  Copyright © 2019 Mobiconnect. All rights reserved.
//

import Foundation

struct News {
  var id:Int?
  var name: String = ""
  var shortDescription: String = ""
  var longDescription: String = ""
  var moreInfo: URL?
  var moreInfoButtonText:String = "More Info"
  var youtubeUrl:URL?
  var createdDate: Date?
  var newsDate: Date?
  var endDate: Date?
  var featured:Bool = false
  var enabled:Bool = false
  var headerImage:URL?
  var images: [URL] = []

  
  init(_ item: [String : Any]) {

    if let id = item["id"] as? Int {
      self.id = id
    }
    if let lname = item["name"] as? String {
      self.name = lname
    }
    if let lshortDescription = item["shortDescription"] as? String {
      self.shortDescription = lshortDescription
    }
    if let llongDescription = item["longDescription"] as? String {
      self.longDescription = llongDescription
    }
    if let lmoreInfo = item["moreInfo"] as? String {
      if lmoreInfo.isValidURL{
        self.moreInfo = URL(string: lmoreInfo)
      }
    }
    if let lmoreInfoButtonText = item["moreInfoButtonText"] as? String {
      self.moreInfoButtonText = lmoreInfoButtonText
    }
    if let lyoutubeUrl = item["youtubeUrl"] as? String {
      if lyoutubeUrl.isValidURL{
        self.youtubeUrl = URL(string: lyoutubeUrl)
      }
    }
    if let lfeatured = item["featured"] as? Bool {
      self.featured = lfeatured
    }
    if let lenabled = item["enabled"] as? Bool {
      self.enabled = lenabled
    }
    if let lcreatedDate = item["createdDate"] as? TimeInterval{
      self.createdDate = lcreatedDate.toDate
    }
    if let lnewsDate = item["newsDate"] as? TimeInterval{
      self.newsDate = lnewsDate.toDate
    }
    if let lendDate = item["endDate"] as? TimeInterval{
      self.endDate = lendDate.toDate
    }
    if let images = item["image"] as? [[String : Any]]{
      for (index,image) in images.enumerated(){
        if let lurl = image["url"] as? String,
          let url = URL(string: lurl){
          if index == 0{
            self.headerImage = url
          }
          self.images.append(url)
        }
      }
    }
  }
}
