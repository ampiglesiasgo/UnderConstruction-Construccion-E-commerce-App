//
//  baseCollectionViewCell.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 6/13/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    var imageUrls = [String]()
    let bannerColletionViewIdentifier = "bannerCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
    }
    
    func configure(imageUrls: [String]) {
        self.imageUrls = imageUrls
        bannerCollectionView.reloadData()
    }
        
    
}

extension BaseCollectionViewCell : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bannerColletionViewIdentifier, for: indexPath) as! BannerCollectionViewCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 12
            cell.bannerImage.layer.masksToBounds = true
            cell.bannerImage.layer.cornerRadius = 12
            cell.bannerImage.kf.setImage(with: URL(string: imageUrls[indexPath.row]))
            return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: bannerCollectionView.frame.size.width , height: bannerCollectionView.frame.size.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}

