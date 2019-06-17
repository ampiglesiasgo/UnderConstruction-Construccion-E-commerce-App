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
    
    @IBOutlet weak var homeActivityIndicator: UIActivityIndicatorView!
    
    var db: Firestore!
    let bannerColletionViewIdentifier = "collectionViewCell"
    let categoriesColletionViewIdentifier = "categoryCell"
    let searchCollectionViewIdentifier = "searchCell"
    var bannersUrl = [String]()
    var itemCount = 0
    var finishBanner = false
    var finishCategory = false
    
    
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
        homeActivityIndicator.isHidden = false
        homeActivityIndicator.startAnimating()
        self.itemCount = 0
        getBanner(db: db) { (finishBanner) in
            if finishBanner{
                for b in ModelManager.shared.banners {
                    self.bannersUrl.append(b.photourl)
                }
                self.itemCount += 2
                self.finishBanner = finishBanner
                
                self.getCategory(db: self.db) { (finishCategory) in
                    if finishCategory{
                        self.itemCount += ModelManager.shared.categories.count
                    }
                    self.finishCategory = finishCategory
                    self.baseCollectionView.reloadData()
                    if finishCategory && finishBanner {
                        let indexPath = IndexPath(row:0, section: 0)
                        self.baseCollectionView.reloadItems(at: [indexPath])
                        var arrayOfIndex = [IndexPath]()
                        for i in 2...ModelManager.shared.categories.count + 1{
                            let indexPath = IndexPath(row: i, section: 0)
                            arrayOfIndex.append(indexPath)
                        }
                        self.baseCollectionView.reloadItems(at: arrayOfIndex)
                        self.homeActivityIndicator.stopAnimating()
                        self.homeActivityIndicator.isHidden = true
                    }
                }
            }
        }
        
    }
    
    
    
    override func viewWillLayoutSubviews() {
//        bannerColletionView.layer.masksToBounds = true
//        bannerColletionView.layer.cornerRadius = 12
//        categoriesSearchBar.layer.masksToBounds = true
//        categoriesSearchBar.layer.cornerRadius = 12
//        categoriesColletionView.layer.masksToBounds = true
//        categoriesColletionView.layer.cornerRadius = 12
    }
    
    

        func getBanner(db : Firestore , completionHandler: @escaping (Bool) -> Void){

            var result = false
            db.collection("Banners").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    completionHandler(result)
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
                        if !(ModelManager.shared.banners.contains(where: { $0.id == id })){
                            let bannner = Banners(name: name, id:id ,photourl:photourl,idBarraca:idBarraca)
                            ModelManager.shared.banners.append(bannner)
                        }
                        
                    }
                    result = true
                    completionHandler(result)
                }
            }
        }
    
    func getCategory(db : Firestore, completionHandler: @escaping (Bool) -> Void){
        var result = false
        db.collection("Categories").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completionHandler(result)
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
                    print("id" + "\(id)")
                    print("Model manager " + "\(ModelManager.shared.categories.contains(where: { $0.id == id }))")
                    if !(ModelManager.shared.categories.contains(where: { $0.id == id })){
                        print("entro " + "\(id)")
                        let category = Category(id:id,name:name,photourl:photourl)
                        ModelManager.shared.categories.append(category)
                    }
                }
                result = true
                completionHandler(result)

            }
        }
    }

}

extension HomeViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == bannerColletionView{
//            return ModelManager.shared.banners.count
//        }
       // return ModelManager.shared.categories.count + 2
        return itemCount
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
            
            let inxPath = indexPath.row - 2
            print("index path row " + "\(inxPath)")
            let category = ModelManager.shared.categories[inxPath]
            
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





