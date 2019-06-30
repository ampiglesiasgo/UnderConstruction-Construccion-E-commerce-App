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
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        if self.isMovingFromParentViewController {
//            barracaViewController?.shopingCartList = shopingCartList
//        }
//    }
    

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
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2 + 60)
    }
}
