//
//  Url.swift
//  Mobiconnect
//
//  Created by Mobiconnect on 4/7/18.
//  Copyright © 2018 Mobiconnect. All rights reserved.
//

import Foundation

struct Urls{

  static let workspaceName = ""
  static let apiKey = ""
  static let baseUrl = "https://\(workspaceName).mobiconnect.net/api/"
  
  // news
  static let news:String = "\(baseUrl)news/findAll?apiKey=\(apiKey)"

}
