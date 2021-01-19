////
//  GalleryViewController.swift
//  sharksmart
//
//  Created by Mrudul Vasavada on 18/02/2016.
//  Copyright © 2016 DPI. All rights reserved.
//

import UIKit
import Alamofire
import CHTCollectionViewWaterfallLayout
import SDWebImage
import IDMPhotoBrowser
import SwiftyGif


class GalleryViewController: BaseViewController{
  
  @IBOutlet weak var collectionView: UICollectionView!
  var cellSizes=[CGSize]()
  var gallery=[IDMPhoto]()
  var galleryImages:[GalleryImage] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //Layout setup
    configureCollectionView()
    
    //Register nibs
    registerNibs()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    downloadGalleryData()
  }
  
  func configureCollectionView(){
    let layout = CHTCollectionViewWaterfallLayout()
    // Change individual layout attributes for the spacing between cells
    layout.sectionInset = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    layout.minimumColumnSpacing = 5.0
    layout.minimumInteritemSpacing = 5.0
    // Collection view attributes
    self.collectionView.autoresizingMask = [UIView.AutoresizingMask.flexibleHeight, UIView.AutoresizingMask.flexibleWidth]
    self.collectionView.alwaysBounceVertical = true
    // Add the waterfall layout to your collection view
    self.collectionView.collectionViewLayout = layout
  }
  
  func registerNibs(){
    // attach the UI nib file for the ImageUICollectionViewCell to the collectionview
    let viewNib = UINib(nibName: "ImageUICollectionViewCell", bundle: nil)
    collectionView.register(viewNib, forCellWithReuseIdentifier: "cell")
  }
  
  func downloadGalleryData(){
    galleryImages.removeAll()
    self.gallery.removeAll()
    APIData.shared.getGallery({images in
      self.galleryImages = images
      if self.galleryImages.count > 0{
        for image in self.galleryImages{
          if let photoUrl =  image.image?.url,
            let url = URL(string: photoUrl){
            let photo:IDMPhoto = IDMPhoto.init(url: url)
            photo.caption = ""
            if let name = image.image?.name{
              photo.caption = name
            }
            if let description = image.image?.note{
              photo.caption += "\n\(description)"
            }
            self.gallery.append(photo)
            //photo size
            let random = Int(arc4random_uniform((UInt32(80))))
            self.cellSizes.append(CGSize(width: 140, height: 80 + random))
          }
        }
      }
      self.collectionView.reloadData()
    })
  }
  
  @IBAction func uploadImage(_ sender: Any) {
    self.pickImagePressed()
  }
}

// MARK: CollectionView Datasource delegate
extension GalleryViewController:UICollectionViewDataSource,CHTCollectionViewDelegateWaterfallLayout{
  //** Number of Cells in the CollectionView */
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return galleryImages.count
  }
  
  //** Create a basic CollectionView Cell */
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    // Create the cell and return the cell
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageUICollectionViewCell
    if galleryImages.count > indexPath.row{
      let photo_data = galleryImages[indexPath.row]
      
      // Add image to cell
      if let imageUrl = photo_data.image?.url,
        let url = URL(string:imageUrl){
        if imageUrl.contains(find: ".gif"){
          cell.image.setGifFromURL(url)
        }else{
          cell.image.sd_setImage(with: url, placeholderImage:nil, options: .refreshCached, completed: { (image, _, type, _) -> Void in
            if image != nil {
              if (type == SDImageCacheType.none || type == SDImageCacheType.disk) {
                UIView.transition(with: cell.image, duration: 0.75, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
                  cell.image.image = image
                }, completion: nil)
              } else {
                cell.image.image = image
              }
            }
          })
        }
      }
    }
    cell.layer.cornerRadius=3.0
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath) as? ImageUICollectionViewCell
    let photoBrowser=IDMPhotoBrowser(photos: self.gallery, animatedFrom: cell)
    
    photoBrowser?.setInitialPageIndex(UInt((indexPath as NSIndexPath).row))
    self.present(photoBrowser!, animated: true) { () -> Void in
      
    }
  }
  
  // MARK: WaterfallLayoutDelegate
  func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAt indexPath: IndexPath!) -> CGSize{
    return cellSizes[indexPath.row]
  }
}

extension GalleryViewController:UIScrollViewDelegate{
  //MARK: scrollview delegate
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let offset = scrollView.contentOffset;
    let bounds = scrollView.bounds;
    let size = scrollView.contentSize;
    let inset = scrollView.contentInset;
    let y = offset.y + bounds.size.height - inset.bottom;
    let h = size.height;
    let reload_distance = 10.0;
    if y > h + CGFloat(reload_distance) {
      downloadGalleryData()
    }
  }
}
