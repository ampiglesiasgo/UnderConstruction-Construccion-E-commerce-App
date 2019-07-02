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
    var product = Product(id:0,name:"",photourl:"",category : "", details : "", price : 0,photoGallery : [String]())
    var shopingCartList = [ShoppingCartItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let barraca = ModelManager.shared.barracas[index]
        logoImageView.kf.setImage(with: URL(string: barraca.photourl))
        self.title = barraca.name
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.back(sender:)))
        newBackButton.image = UIImage(named: "back")
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(addTapped))
        if shopingCartList.count == 0 {
            navigationItem.rightBarButtonItem?.image = UIImage(named: "carritoVacio")
        }
        else {navigationItem.rightBarButtonItem?.image = UIImage(named: "carritolleno")}
        navigationItem.rightBarButtonItem?.tintColor = .black

        products = ModelManager.shared.barracas[index].products
        productsCollectionView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        logoImageView.layer.masksToBounds = true
        logoImageView.layer.cornerRadius = 12
        
    }
    @objc func addTapped() {
        self.performSegue(withIdentifier: "toShoppingCart", sender: self)

    }
    

    @objc func back(sender: UIBarButtonItem) {
        
        if shopingCartList.count > 0 {
            let alert = UIAlertController(title: "¿Estas seguro de que queres salir?", message: "Al hacerlo, se eliminara tu pedido.", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Si, Salir", style: .default, handler: { (action: UIAlertAction!) in
                _ = self.navigationController?.popViewController(animated: true)
            }))
            
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Stay here")
            }))
            
            present(alert, animated: true, completion: nil)
        }
        else {
            _ = self.navigationController?.popViewController(animated: true)

        }
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
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var index = 0
        let cell = productsCollectionView.cellForItem(at: indexPath) as! BarracaProductCollectionViewCell
        if let i = ModelManager.shared.productos.firstIndex(where: { $0.name == cell.productNameLabel.text }) {
            index = i
        }
        product = ModelManager.shared.productos[index]
        self.performSegue(withIdentifier: "toProductDetails", sender: self)

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toProductDetails"{
            let productDetailsViewController = (segue.destination as! ProductDetailsViewController)
            productDetailsViewController.product = product
            productDetailsViewController.barracaViewController = self
            
            
        }
        if segue.identifier == "toShoppingCart"{
            let shoppingCartViewController = (segue.destination as! ShoppingCartViewController)
            shoppingCartViewController.barracaViewController = self
            shoppingCartViewController.shopingCartList = shopingCartList
            
            
        }
    }
    
    
}
