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
    @IBOutlet weak var buyProductButton: UIButton!
    
    var product = Product(id:0,name:"",photourl:"",category : "", details : "", price : 0, photoGallery : [String]())
    var barracaViewController:BarracaViewController?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        productNameLabel.text = product.name
        productDetailsLabel.text = product.details
        productPriceLabel.text = "$ " +  "\(product.price)"
    }
    
    override func viewWillLayoutSubviews() {
        buyProductButton.layer.cornerRadius = 15
        buyProductButton.clipsToBounds = true
    }
    
    @IBAction func productPurchaseButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: "productPurchaseDetail", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "productPurchaseDetail"{
            let productFinalDetailsViewController = (segue.destination as! ProductFinalDetailsViewController)
            productFinalDetailsViewController.product = product
            productFinalDetailsViewController.barracaViewController = barracaViewController
            
            
        }
    }

}

extension ProductDetailsViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product.photoGallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productPhotosCell", for: indexPath) as! ProductPhotoCollectionViewCell
        cell.productImage.kf.setImage(with: URL(string: product.photoGallery[indexPath.row]))
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 12
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize, height: collectionViewSize)
    }
    
}
