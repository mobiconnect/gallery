//
//  BaseViewController.swift
//  Aotomot
//
//  Created by AOTOMOT on 4/7/18.
//  Copyright © 2018 Aotomot. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, UINavigationControllerDelegate{
  
  let photoPicker=UIImagePickerController()
  var selectedImage:UIImage?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    self.setNeedsStatusBarAppearanceUpdate()
    self.view.backgroundColor =  UIColor(hex: "#F7F9F8")
  }

  override var prefersStatusBarHidden: Bool {
    get {
      return true
    }
  }
  
  func pickImagePressed(){
    photoPicker.navigationBar.isTranslucent = false
    photoPicker.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    photoPicker.navigationBar.shadowImage = UIImage()
    let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
    //Create and add the Cancel action
    let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
      //Just dismiss the action sheet
    }
    actionSheetController.addAction(cancelAction)
    //Create and add first option action
    let cameraAction: UIAlertAction = UIAlertAction(title: "Camera", style: .default) { action -> Void in
      if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
        self.photoPicker.sourceType=UIImagePickerController.SourceType.camera
        self.photoPicker.delegate = self
        self.present(self.photoPicker, animated: true, completion: {
        })
      }else{
        Utility.showAlert("Sorry", message: "Camera is not available")
      }
    }
    actionSheetController.addAction(cameraAction)
    
    //Create and add a second option action
    let libraryAction: UIAlertAction = UIAlertAction(title: "Photo Library", style: .default) { action -> Void in
      self.photoPicker.sourceType=UIImagePickerController.SourceType.photoLibrary
      self.photoPicker.delegate=self
      self.present(self.photoPicker, animated: true, completion: nil)
    }
    actionSheetController.addAction(libraryAction)
    
    //Create and add a second option action
    let albumAction: UIAlertAction = UIAlertAction(title: "Photo Album", style: .default) { action -> Void in
      self.photoPicker.sourceType=UIImagePickerController.SourceType.savedPhotosAlbum
      self.photoPicker.delegate=self
      self.present(self.photoPicker, animated: true, completion: nil)
    }
    actionSheetController.addAction(albumAction)
    
    //We need to provide a popover sourceView when using it on iPad
    //Present the AlertController
    self.present(actionSheetController, animated: true, completion: {
    })
  }
}


extension BaseViewController:UIImagePickerControllerDelegate {
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    self.dismiss(animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    // Local variable inserted by Swift 4.2 migrator.
    let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
    
    if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage{
      self.selectedImage=nil
      self.selectedImage=image
      
      if picker.sourceType==UIImagePickerController.SourceType.camera {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
      }
      
      self.dismiss(animated: true, completion: {
        if let viewController:ImageUploadViewController = UIStoryboard(name: "Gallery", bundle: Bundle.main).instantiateViewController(withIdentifier: "ImageUploadViewController") as? ImageUploadViewController{
          viewController.selectedImage = self.selectedImage
          self.present(viewController, animated: true, completion: nil)
        }
      })
    }
  }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
  return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
  return input.rawValue
}

