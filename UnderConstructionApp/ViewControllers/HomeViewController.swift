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
    
    @IBOutlet weak var baseCollectionView: UICollectionView!
    
    
    var db: Firestore!
    let bannerColletionViewIdentifier = "collectionViewCell"
    let categoriesColletionViewIdentifier = "categoryCell"
    let searchCollectionViewIdentifier = "searchCell"
    var bannersUrl = [String]()
    
    
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
//        let bannner = Banners(name: "name", id:1 ,photourl: "https://firebasestorage.googleapis.com/v0/b/underconstructionapp-578d2.appspot.com/o/Banners%2FBanner1.jpg?alt=media&token=9faee060-4642-4175-9b8d-42300a13f337",idBarraca:1)
//        ModelManager.shared.banners.append(bannner)
//        let indexPath = IndexPath(row:0, section: 0)
//        self.baseCollectionView.reloadItems(at: [indexPath])
        
        
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



                for b in ModelManager.shared.banners {
                    self.bannersUrl.append(b.photourl)
                }

                let indexPath = IndexPath(row:0, section: 0)
                self.baseCollectionView.reloadItems(at: [indexPath])

             
                //                self.baseCollectionView.reloadData()
//                print("executed")
            }
        }
//        db.collection("Categories").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                var id = 0
//                var name = ""
//                var photourl = ""
//                for document in querySnapshot!.documents {
//                    let categoryData = document.data()
//                    for data in categoryData{
//                        if data.key == "id"{
//                            id = data.value as! Int
//                        }
//                        if data.key == "name"{
//                            name = data.value as! String
//                        }
//                        if data.key == "photourl"{
//                            photourl = data.value as! String
//                        }
//
//                    }
//                    let category = Category(id:id,name:name,photourl:photourl)
////                    ModelManager.shared.categories.append(category)
//
//                }
////                for i in 2...ModelManager.shared.categories.count + 2 {
////                    let indexPath = IndexPath(row: i, section: 0)
////                    self.baseCollectionView.reloadItems(at: [indexPath])
////                }
//            }
//        }
        
        
    }
    override func viewWillLayoutSubviews() {
//        bannerColletionView.layer.masksToBounds = true
//        bannerColletionView.layer.cornerRadius = 12
//        categoriesSearchBar.layer.masksToBounds = true
//        categoriesSearchBar.layer.cornerRadius = 12
//        categoriesColletionView.layer.masksToBounds = true
//        categoriesColletionView.layer.cornerRadius = 12
    }

}

extension HomeViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == bannerColletionView{
//            return ModelManager.shared.banners.count
//        }
        return ModelManager.shared.categories.count + 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bannerColletionViewIdentifier, for: indexPath) as! BaseCollectionViewCell
            cell.configure(imageUrls: bannersUrl)
//            cell.bannerCollectionView.reloadData()
            return cell
        }
        if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchCollectionViewIdentifier, for: indexPath) as! SearchCollectionViewCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 12
            cell.collectionSearchBar.layer.masksToBounds = true
            cell.collectionSearchBar.layer.cornerRadius = 12
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoriesColletionViewIdentifier, for: indexPath) as! CategoriesCollectionViewCell
            let category = ModelManager.shared.categories[indexPath.row - 2]
            
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 12
            cell.categoryLabel.text = category.name
            cell.categoryImageView.kf.setImage(with: URL(string: category.photourl))
            
            return cell
        }
        
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: baseCollectionView.frame.size.width , height: 150)
        }
        if indexPath.row == 1 {
            return CGSize(width: baseCollectionView.frame.size.width , height: 56)

        }
        else {
        let padding: CGFloat =  1
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2 + 30)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}






