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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let barraca = ModelManager.shared.barracas[index]
        logoImageView.kf.setImage(with: URL(string: barraca.photourl))
        self.title = barraca.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem?.image = UIImage(named: "carritoVacio")
        navigationItem.rightBarButtonItem?.tintColor = .black

        products = ModelManager.shared.barracas[index].products
        productsCollectionView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        logoImageView.layer.masksToBounds = true
        logoImageView.layer.cornerRadius = 12
        
    }
    @objc func addTapped() {
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
        let screenSize: CGRect = cell.frame
        cell.productImageView.frame = CGRect(x: 18, y: 18, width: screenSize.width * 0.80, height: screenSize.width * 0.80)
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
            
            
        }
    }
    
    
}
