//
//  ProductDetailsViewController.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 6/23/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit
import Kingfisher

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDetailsLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productPhotosCollectionView: UICollectionView!
    var product = Product(id:0,name:"",photourl:"",category : "", details : "", price : 0, photoGallery : [String]())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        productNameLabel.text = product.name
        productDetailsLabel.text = product.details
        productPriceLabel.text = "$ " +  "\(product.price)"
    }


}

extension ProductDetailsViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product.photoGallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productPhotosCell", for: indexPath) as! ProductPhotoCollectionViewCell
        cell.productImage.kf.setImage(with: URL(string: product.photoGallery[indexPath.row]))
        
        return cell
    }
    
    
    
}
