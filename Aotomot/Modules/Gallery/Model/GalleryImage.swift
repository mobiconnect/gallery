//
//  GalleryImage.swift
//  DriverManagement
//
//  Created by Mobiddiction on 4/9/18.
//  Copyright © 2018 mobiddiction. All rights reserved.
//

import Foundation

struct GalleryImage{
  var id:Int?
  var name:String?
  var galleryId:Int?
  var description:String?
  var note:String?
  var adminNote:String?
  var approved:Bool = false
  var pending:Bool = false
  var image:Image?
  var createdDate:Date?
  var lastModifiedDate:Date?
  
  init(_ galleryItem: [String : Any]) {
    
    if let lid = galleryItem["id"] as? Int{
      id = lid
    }
    
    if let lname = galleryItem["name"] as? String{
      name = lname
    }
    
    if let lgalleryId = galleryItem["galleryId"] as? Int{
      galleryId = lgalleryId
    }
    
    if let ldescription = galleryItem["description"] as? String{
      description = ldescription
    }
    
    if let lnote = galleryItem["note"] as? String{
      note = lnote
    }
    
    if let ladminNote = galleryItem["adminNote"] as? String{
      adminNote = ladminNote
    }
    
    if let lapproved = galleryItem["approved"] as? Bool{
      approved = lapproved
    }
    
    if let lpending = galleryItem["pending"] as? Bool{
      pending = lpending
    }
    
    if let limage = galleryItem["image"] as? [String:Any]{
      image = Image(limage)
    }
    
    if let lcreatedDate = galleryItem["createdDate"] as? Double{
      createdDate = lcreatedDate.toDate
    }
    
    if let llastModifiedDate = galleryItem["lastModifiedDate"] as? Double{
      lastModifiedDate = llastModifiedDate.toDate
    }
    
  }
}

