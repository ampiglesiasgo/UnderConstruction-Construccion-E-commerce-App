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
    var db: Firestore!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //ModelManager.shared.setBannerData(db: db)
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
    }
    override func viewWillLayoutSubviews() {
        bannerColletionView.layer.masksToBounds = true
        bannerColletionView.layer.cornerRadius = 12
    }

}

extension HomeViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ModelManager.shared.banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as! BannerCollectionViewCell
        let banner = ModelManager.shared.banners[indexPath.row]
//        if let bannerImageName = banner.bannerImageName {
//            cell.imageBannerViewOutlet.kf.setImage(with: URL(string: bannerImageName))
//        }
//        else{
//            cell.imageBannerViewOutlet.image = UIImage(named:"No_image")
//        }
//        if let bannerTittle =  banner.bannerTittle{
//            cell.tittleLabelOutlet.text = bannerTittle
//        }
//        else {cell.tittleLabelOutlet.text = "The banner tittle in not available"}
//        if let bannerDescription = banner.bannerDescription  {
//            cell.descriptionLabelOutlet.text = bannerDescription
//        }
//        else {cell.descriptionLabelOutlet.text = "The banner description in not available"}
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 12
        cell.bannerImage.layer.masksToBounds = true
        cell.bannerImage.layer.cornerRadius = 12
        cell.bannerImage.kf.setImage(with: URL(string: banner.photourl))

        return cell

        
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bannerColletionView.frame.size.width , height: bannerColletionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}
