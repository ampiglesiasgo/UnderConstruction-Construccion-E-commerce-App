//
//  BarracaProductCollectionViewCell.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 6/22/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit

class BarracaProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    override func layoutSubviews() {
        productImageView.layer.masksToBounds = true
        productImageView.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 12
       // productImageView.layer.borderColor = UIColor.black.cgColor
       // productImageView.layer.borderWidth = 1
        
    }
}
