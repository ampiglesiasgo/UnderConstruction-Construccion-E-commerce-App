//
//  HomeViewController.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 6/9/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    @IBOutlet weak var bannerColletionView: UICollectionView!
    
    @IBOutlet weak var backYellowView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillLayoutSubviews() {
        backYellowView.layer.cornerRadius = 8
    }

}

extension HomeViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as! BannerCollectionViewCell
//        //let banner = ModelManager.shared.banners[indexPath.row]
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
        
        cell.bannerImage.layer.masksToBounds = true
        cell.bannerImage.layer.cornerRadius = 12
        cell.bannerImage.kf.setImage(with: URL(string: "https://firebasestorage.googleapis.com/v0/b/underconstructionapp-578d2.appspot.com/o/Banners%2FBanner1.jpg?alt=media&token=9faee060-4642-4175-9b8d-42300a13f337"))

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
