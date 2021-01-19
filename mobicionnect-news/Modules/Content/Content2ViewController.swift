//
//  Content2ViewController.swift
//  Mobiconnect_iOS
//
//  Created by Mobiddiction on 8/9/17.
//  Copyright © 2017 Mobiddiction. All rights reserved.
//

import UIKit

class Content2ViewController: BaseViewController {
  
  @IBOutlet weak var tableView: UITableView!
  var latestNews: [News] = []
  var storedOffsets = [Int: CGFloat]()
  var refreshControl: UIRefreshControl = UIRefreshControl()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.backgroundColor = UIColor(hex: "#F7F9F8")
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
      self.latestNews = news
      self.tableView.reloadData()
      self.refreshControl.endRefreshing()
    })
  }
}

extension Content2ViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    CellAnimator.animateCell(cell: cell, withTransform: CellAnimator.TransformHelix, andDuration: 0.5)
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let news = self.latestNews[indexPath.row]
    let storyboard = UIStoryboard(name: "Content", bundle: nil)
    let detailViewVC: ContentDetailViewController = storyboard.instantiateViewController(withIdentifier: "ContentDetailsVC") as! ContentDetailViewController
    detailViewVC.newsInfo = news
    self.navigationController?.pushViewController(detailViewVC, animated: true)
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView=UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0.0))
    return headerView
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 0.0
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let headerView=UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0.0))
    return headerView
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.0
  }
}

extension Content2ViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.latestNews.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row % 2 == 0{
      let cell=tableView.dequeueReusableCell(withIdentifier: "NewsListLeft", for: indexPath) as! NewsList
      let newsInfo = self.latestNews[indexPath.row]
      cell.updateData(newsInfo)
      cell.selectionStyle = .none
      return cell
    }else{
      let cell=tableView.dequeueReusableCell(withIdentifier: "NewsListRight", for: indexPath) as! NewsList
      let newsInfo = self.latestNews[indexPath.row]
      cell.updateData(newsInfo)
      cell.selectionStyle = .none
      return cell
    }
  }
}

