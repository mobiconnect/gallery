//
//  APIData.swift
//  Mobiconnect
//
//  Created by Mobiconnect on 4/7/18.
//  Copyright © 2018 Mobiconnect. All rights reserved.
//

import UIKit
import Alamofire

class APIData: NSObject {
  class var shared: APIData {
    struct Singleton {
      static let instance = APIData()
    }
    return Singleton.instance
  }
  
  /// network error
  struct MBDError : Error
  {
    public var code:Int
    public var message:String
    public var apiMessage:String
    
    public init(code: Int?,apiMessage:Any?)
    {
      self.code = code ?? 500
      switch code {
      case 400:
        self.message = "We are unable to process your request at this time."
      case 401:
        self.message = "Seems you don't have the right access."
      case 403:
        self.message = "Seems you don't have the right access."
      case 404:
        self.message = "We can't seem to find that."
      default:
        self.message = "Seems there's a problem, please try again in a while."
      }
      if apiMessage != nil,let response = apiMessage as? [String:Any], let message = response["message"] as? String{
        self.apiMessage = message
      }else{
        self.apiMessage = self.message
      }
    }
  }
  
  func getContent(_ success:@escaping ([News]) -> Void){
      if !Reachability.isConnectedToNetwork(){
        return
      }
      
      let headers = [
        "accept":"application/json",
      ]
      Alamofire.request(Urls.news,method: .get, parameters: nil, encoding: URLEncoding.default,headers: headers)
        .responseJSON { response in
          print("\n**************************\nresponse code:\(response.response?.statusCode ?? 500)\nresponse:\((response.result.value ?? "No result value"))\n**************************\n")
          if response.result.isSuccess{
            if response.response?.statusCode == 200{
              var newsItems:[News] = []
              if let newsArray = response.result.value as? [[String:Any]] {
                for news in newsArray{
                  let newsInfo = News(news)
                  if newsInfo.enabled{
                    newsItems.append(newsInfo)
                  }
                }
                newsItems.sort(by: { $0.createdDate?.compare($1.createdDate!) == .orderedDescending })
                success(newsItems)
              }else{
                let error = MBDError(code: response.response?.statusCode, apiMessage: response.result.value)
                Utility.showAlert(message: error.message)
              }
            }else{
              let error = MBDError(code: response.response?.statusCode, apiMessage: response.result.value)
              Utility.showAlert(message: error.message)
            }
          }else{
            let error = MBDError(code: response.response?.statusCode, apiMessage: response.result.value)
            Utility.showAlert(message: error.message)
          }
      }
    }
}


