//
//  CategoriesCollectionViewCell.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 6/12/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit

protocol CategoriesCollectionViewCellDelegate {
    func didTapCategory(_ sender: CategoriesCollectionViewCell, category : String)
}

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    var delegate : CategoriesCollectionViewCell?
    


}
