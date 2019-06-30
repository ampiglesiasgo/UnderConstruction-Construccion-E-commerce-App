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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


       // BarracaViewController?.popViewController(animated: true)
//
//        if let destionationViewController = navigationController?.viewControllers[navigationController?.viewControllers.count ?? 3 - 3] {
//            navigationController?.popToViewController(destionationViewController, animated: true)
//        }
        
//        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
//        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 4], animated: true)

    

}


extension ShoppingCartViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shoppingItemCell", for: indexPath) as! ShoppingCartItemCollectionViewCell
        
        return cell
    }
}
