//
//  Document.swift
//  Aotomot
//
//  Created by Mobiddiction on 4/9/18.
//  Copyright © 2018 mobiddiction. All rights reserved.
//

import Foundation

struct Image{
  var id:Int?
  var url:String?
  var clientId:Int?
  var userId:Int?
  var newsId:Int?
  var eventId:Int?
  var driverId:Int?
  var galleryId:Int?
  var note:String?
  var name:String?
  var expiry:Date?
  var lastModifiedDate:Date?
  var profile:Bool = false
  var favourite:Bool = false
  var deleted:Bool = false
  
  init(_ document: [String : Any]) {
    
    if let lid = document["id"] as? Int{
      id = lid
    }
    
    if let lurl = document["url"] as? String{
      url = lurl
    }
    
    if let lclientId = document["clientId"] as? Int{
      clientId = lclientId
    }
    
    if let luserId = document["userId"] as? Int{
      userId = luserId
    }
    
    if let lnewsId = document["newsId"] as? Int{
      newsId = lnewsId
    }
    
    if let leventId = document["eventId"] as? Int{
      eventId = leventId
    }
    
    if let ldriverId = document["driverId"] as? Int{
      driverId = ldriverId
    }
    
    if let lgalleryId = document["galleryId"] as? Int{
      galleryId = lgalleryId
    }
    
    if let lnote = document["note"] as? String{
      note = lnote
    }
    
    if let lname = document["name"] as? String{
      name = lname
    }
    
    if let lexpiry = document["expiry"] as? Double{
      expiry = lexpiry.toDate
    }
    
    if let llastModifiedDate = document["lastModifiedDate"] as? Double{
      lastModifiedDate = llastModifiedDate.toDate
    }
    
    if let lprofile = document["profile"] as? Bool{
      profile = lprofile
    }
    
    if let lfavourite = document["favourite"] as? Bool{
      favourite = lfavourite
    }
    
    if let ldeleted = document["deleted"] as? Bool{
      deleted = ldeleted
    }
  }
}

