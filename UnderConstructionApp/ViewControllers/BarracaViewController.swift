//
//  BarracaViewController.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 6/22/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit
import Kingfisher

class BarracaViewController: UIViewController {

    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var logoImageView: UIImageView!
    var index = 0
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let barraca = ModelManager.shared.barracas[index]
        logoImageView.kf.setImage(with: URL(string: barraca.photourl))
        self.title = barraca.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        products = ModelManager.shared.barracas[index].products
        productsCollectionView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        logoImageView.layer.masksToBounds = true
        logoImageView.layer.cornerRadius = 12
    }

}

extension BarracaViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "barracaProductCell", for: indexPath) as! BarracaProductCollectionViewCell
        let product = products[indexPath.row]
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.productImageView.kf.setImage(with: URL(string: product.photourl))
        cell.productNameLabel.text = product.name
        cell.productPriceLabel.text = "$ " + "\(product.price)"
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2 + 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//            let cell = baseCollectionView.cellForItem(at: indexPath) as! CategoriesCollectionViewCell
//            filterCategory = cell.categoryLabel.text!
//            
//            self.performSegue(withIdentifier: "categorySegue", sender: self)
//
//    }
//    
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if segue.identifier == "categorySegue"{
//            let barracasTableViewController = (segue.destination as! BarracasTableViewController)
//            barracasTableViewController.filterCategory = filterCategory
//            
//            
//        }
//    }
//    
    
}
