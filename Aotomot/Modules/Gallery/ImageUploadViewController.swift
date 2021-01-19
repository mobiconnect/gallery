//
//  ImageUploadViewController.swift
//  Mobiconnect_iOS
//
//  Created by Mobiddiction on 19/9/17.
//  Copyright © 2017 Mobiddiction. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire

class ImageUploadViewController: UIViewController {
  
  @IBOutlet var postImage: UIImageView!
  @IBOutlet weak var txtfTitle: UITextField!
  @IBOutlet weak var txtvDescription: UITextView!
  @IBOutlet weak var viewDescription: UIView!
  var selectedImage:UIImage?
  var isProfilePic:Bool = false
  var isSignature:Bool = false
  let kAddComment = "Add Comments"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    self.postImage.image = self.selectedImage
    self.view.layoutIfNeeded()
  }
  
  @IBAction func cancelPressed(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func uploadPressed(_ sender: Any) {
    DispatchQueue.main.async(execute: {
      
      if let _image = self.postImage.image {
        
      }
    })
  }
}

extension ImageUploadViewController:UITextViewDelegate{
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.text == kAddComment{
      textView.text = ""
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text == ""{
      textView.text = kAddComment
    }
  }
}

