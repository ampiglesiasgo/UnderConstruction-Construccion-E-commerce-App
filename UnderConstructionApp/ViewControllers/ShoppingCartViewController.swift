//
//  ShoppingCartViewController.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 6/27/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit

class ShoppingCartViewController: UIViewController {
    
    
    var shopingCartList = [ShoppingCartItem]()
    var barracaViewController:BarracaViewController?


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}


extension ShoppingCartViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopingCartList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shoppingItemCell", for: indexPath) as! ShoppingCartItemCollectionViewCell
        let shopItem = shopingCartList[indexPath.row]
        cell.shoppingCartImage.kf.setImage(with: URL(string: shopItem.product.photourl))
        cell.shoppingCartItemName.text = shopItem.product.name
        cell.shoppingCartItemPrice.text = "$ " + "\(shopItem.subTotal)"
        cell.shoppingCartItemUnit.text = shopItem.unit
        cell.shoppingCartItemQuantity.text = "\(shopItem.quantity)"
        cell.contentView.layer.cornerRadius = 12
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2 + 60)
    }
}
