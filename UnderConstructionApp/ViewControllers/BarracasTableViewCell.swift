//
//  BarracasTableViewCell.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 6/17/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit

class BarracasTableViewCell: UITableViewCell {

    @IBOutlet weak var barracaNameLabel: UILabel!
    @IBOutlet weak var barracaAddressLabel: UILabel!
    @IBOutlet weak var barracaDetailsLabel: UILabel!
    @IBOutlet weak var barracasPhotoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        barracasPhotoImageView.layer.cornerRadius = 15
    }

}
