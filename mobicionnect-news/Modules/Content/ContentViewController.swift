//
//  ContentViewController.swift
//  Mobiconnect_iOS
//
//  Created by Mobiddiction on 8/9/17.
//  Copyright © 2017 Mobiddiction. All rights reserved.
//

import UIKit

class ContentViewController: BaseViewController {
  
  @IBOutlet weak var tableView: UITableView!
  var featuredNews: [News] = []
  var latestNews: [News] = []
  var storedOffsets = [Int: CGFloat]()
  var refreshControl: UIRefreshControl = UIRefreshControl()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    self.tableView.backgroundColor = UIColor(hex: "#F7F9F8")

    let textHeaderView = UINib(nibName: "TableViewHeaderCell", bundle: nil)
    self.tableView.register(textHeaderView, forHeaderFooterViewReuseIdentifier: "TableViewHeaderCell")
    
    let newsEmptyFooter = UINib(nibName: "ContentEmptyFooter", bundle: nil)
    self.tableView.register(newsEmptyFooter, forHeaderFooterViewReuseIdentifier: "ContentEmptyFooter")
    
    self.tableView.contentInsetAdjustmentBehavior = .never
    self.getLatestNews()
    self.addRefreshController()
  }
  
  func addRefreshController(){
    refreshControl.tintColor = UIColor(hex: "#E31349")
    self.tableView.refreshControl = refreshControl
    refreshControl.addTarget(self, action: #selector(getLatestNews), for: .valueChanged)
  }

  @objc func getLatestNews(){
    APIData.shared.getContent({news in
      self.latestNews = news.filter({!$0.featured})
      self.featuredNews = news.filter({$0.featured})
      self.tableView.reloadData()
      self.refreshControl.endRefreshing()
    })
  }
}

extension ContentViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
    if indexPath.section == 0
      && self.featuredNews.count > 0{
      guard let tableViewCell = cell as? CollectionTableViewCell else { return }
      
      tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
      tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }else{
      CellAnimator.animateCell(cell: cell, withTransform: CellAnimator.TransformTilt, andDuration: 0.5)
    }
  }
  
  func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
    if indexPath.section == 0
      && self.featuredNews.count > 0{
      guard let tableViewCell = cell as? CollectionTableViewCell else { return }
      storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
  }
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let news = self.latestNews[indexPath.row]
    let storyboard = UIStoryboard(name: "Content", bundle: nil)
    let detailViewVC: ContentDetailViewController = storyboard.instantiateViewController(withIdentifier: "ContentDetailsVC") as! ContentDetailViewController
    detailViewVC.newsInfo = news
    self.present(detailViewVC, animated: true, completion: nil)
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let cell=tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableViewHeaderCell") as! TableViewHeaderCell
    if section == 0
      && self.featuredNews.count > 0{
      cell.titleLabel.text = "Featured Article"
    }else {
      cell.titleLabel.text = "Latest News"
    }
    return cell
    
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if self.featuredNews.count > 0{
      return 60.0
    }else {
      return 0.0
    }
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    if self.latestNews.count > 0
      || self.featuredNews.count > 0{
      let headerView=UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0.0))
      headerView.backgroundColor = UIColor(hex: "#F7F9F8")
      return headerView
    }else {
      let cell=tableView.dequeueReusableHeaderFooterView(withIdentifier: "ContentEmptyFooter") as! ContentEmptyFooter
      cell.updateView("You currently have any News to show")
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    if self.latestNews.count > 0
      || self.featuredNews.count > 0{
      return 0.0
    }else {
      return 351.0
    }
  }
}

extension ContentViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    var numSection = 0
    numSection = self.featuredNews.count > 0 ? 1 : 0
    numSection = self.latestNews.count > 0 ? numSection+1 : numSection
    return numSection
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0
      && self.featuredNews.count > 0{
      return 1
    }else{
      return self.latestNews.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if self.featuredNews.count == 0{
      let cell=tableView.dequeueReusableCell(withIdentifier: "NewsImageListCell", for: indexPath) as! NewsImageListCell
      let newsInfo = self.latestNews[indexPath.row]
      cell.configureCell(newsInfo)
      cell.selectionStyle = .none
      return cell
    }else{
      if indexPath.section == 0{
        let cell=tableView.dequeueReusableCell(withIdentifier: "CollectionTableViewCell", for: indexPath) as! CollectionTableViewCell
        cell.selectionStyle = .none
        return cell
      }else{
        let cell=tableView.dequeueReusableCell(withIdentifier: "NewsListCell", for: indexPath) as! NewsListCell
        let newsInfo = self.latestNews[indexPath.row]
        cell.updateData(newsInfo)
        cell.selectionStyle = .none
        return cell
      }
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if self.featuredNews.count > 0
    && indexPath.section == 0{
      return 260.0
    }else{
      return UITableView.automaticDimension
    }
  }
}

extension ContentViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.featuredNews.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCollectionCell", for: indexPath) as! FeaturedCollectionCell
    let newsInfo = self.featuredNews[indexPath.row]
    cell.updateData(newsInfo: newsInfo)
    cell.addShadow()
    return cell
  }
}

extension ContentViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let news = self.featuredNews[indexPath.row]
    let storyboard = UIStoryboard(name: "Content", bundle: nil)
    let detailViewVC: ContentDetailViewController = storyboard.instantiateViewController(withIdentifier: "ContentDetailsVC") as! ContentDetailViewController
    detailViewVC.newsInfo = news
    self.present(detailViewVC, animated: true, completion: nil)
  }
}


