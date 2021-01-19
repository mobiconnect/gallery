//
//  CollectionTableViewCell.swift
//  Mobiconnect_iOS
//
//  Created by Mobiddiction on 12/9/17.
//  Copyright © 2017 Mobiddiction. All rights reserved.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let featuredCollectionCell = UINib(nibName: "FeaturedCollectionCell", bundle: nil)
        self.collectionView.register(featuredCollectionCell, forCellWithReuseIdentifier: "FeaturedCollectionCell")

        let rewardsCollectionCell = UINib(nibName: "RewardsCollectionCell", bundle: nil)
        self.collectionView.register(rewardsCollectionCell, forCellWithReuseIdentifier: "RewardsCollectionCell")

        // cell size
        self.collectionLayout.scrollDirection = .horizontal
        self.collectionLayout.minimumInteritemSpacing = 10
        self.collectionLayout.minimumLineSpacing = 10
        self.collectionLayout.sectionInset = UIEdgeInsets(top: 10, left:20, bottom: 10, right: 20)
        // cell size
        let itemWidth = (UIScreen.main.bounds.size.width/1.2)-20
        self.collectionLayout.itemSize = CGSize(width: itemWidth, height: itemWidth/1.2)

        let collectionViewHeight = self.collectionLayout.collectionView?.bounds.size.height ?? 0
        self.collectionLayout.headerReferenceSize = CGSize(width: 0, height: collectionViewHeight)
      self.collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        self.contentView.backgroundColor = UIColor(hex: "#F7F9F8")
        self.collectionView.backgroundColor = UIColor(hex: "#F7F9F8")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension CollectionTableViewCell {
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {

        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        collectionView.reloadData()
    }

    var collectionViewOffset: CGFloat {
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }
}
