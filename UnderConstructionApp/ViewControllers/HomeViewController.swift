//
//  HomeViewController.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 6/9/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseFirestore

class HomeViewController: UIViewController {
    @IBOutlet weak var bannerColletionView: UICollectionView!
    @IBOutlet weak var categoriesColletionView: UICollectionView!
    
    @IBOutlet weak var categoriesSearchBar: UISearchBar!
    var db: Firestore!
    let bannerColletionViewIdentifier = "bannerCell"
    let categoriesColletionViewIdentifier = "categoryCell"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        db.collection("Banners").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var id = 0
                var name = ""
                var photourl = ""
                var idBarraca = 0
                for document in querySnapshot!.documents {
                    let bannerData = document.data()
                    for data in bannerData{
                        if data.key == "id"{
                            id = data.value as! Int
                        }
                        if data.key == "name"{
                            name = data.value as! String
                        }
                        if data.key == "photourl"{
                            photourl = data.value as! String
                        }
                        if data.key == "idBarraca"{
                            idBarraca = data.value as! Int
                        }
                    }
                    let bannner = Banners(name: name, id:id ,photourl:photourl,idBarraca:idBarraca)
                    ModelManager.shared.banners.append(bannner)
                    
            }
            self.bannerColletionView.reloadData()
            }
            }
        db.collection("Categories").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var id = 0
                var name = ""
                var photourl = ""
                for document in querySnapshot!.documents {
                    let categoryData = document.data()
                    for data in categoryData{
                        if data.key == "id"{
                            id = data.value as! Int
                        }
                        if data.key == "name"{
                            name = data.value as! String
                        }
                        if data.key == "photourl"{
                            photourl = data.value as! String
                        }

                    }
                    let category = Category(id:id,name:name,photourl:photourl)
                    ModelManager.shared.categories.append(category)
                    
                }
                self.categoriesColletionView.reloadData()
            }
        }
        
        
    }
    override func viewWillLayoutSubviews() {
        bannerColletionView.layer.masksToBounds = true
        bannerColletionView.layer.cornerRadius = 12
        categoriesSearchBar.layer.masksToBounds = true
        categoriesSearchBar.layer.cornerRadius = 12
        categoriesColletionView.layer.masksToBounds = true
        categoriesColletionView.layer.cornerRadius = 12
    }

}

extension HomeViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bannerColletionView{
            return ModelManager.shared.banners.count
        }
        return ModelManager.shared.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bannerColletionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bannerColletionViewIdentifier, for: indexPath) as! BannerCollectionViewCell
            let banner = ModelManager.shared.banners[indexPath.row]
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 12
            cell.bannerImage.layer.masksToBounds = true
            cell.bannerImage.layer.cornerRadius = 12
            cell.bannerImage.kf.setImage(with: URL(string: banner.photourl))
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoriesColletionViewIdentifier, for: indexPath) as! CategoriesCollectionViewCell
        let category = ModelManager.shared.categories[indexPath.row]

        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 12
        cell.categoryLabel.text = category.name
        cell.categoryImageView.kf.setImage(with: URL(string: category.photourl))

        return cell
        
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bannerColletionView{
            return CGSize(width: bannerColletionView.frame.size.width , height: bannerColletionView.frame.size.height)
        }

        //let padding: CGFloat =  20
        let padding: CGFloat =  1
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2 + 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}






