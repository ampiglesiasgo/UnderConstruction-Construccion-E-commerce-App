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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParentViewController {
            barracaViewController?.shopingCartList = shopingCartList
        }
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
        return shopingCartList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shoppingItemCell", for: indexPath) as! ShoppingCartItemCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2 + 60)
    }
}
