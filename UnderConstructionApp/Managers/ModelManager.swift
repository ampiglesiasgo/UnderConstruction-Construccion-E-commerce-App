//
//  ModelManager.swift
//  PrimerObligatorio
//
//  Created by Amparo Iglesias on 4/25/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ModelManager {
    //Model
    private init() {}

    static let shared = ModelManager()
    var banners = [Banners]()
    
    //Set the data of the banners
    func setBannerData(db: Firestore){
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
                    self.banners.append(bannner)
                    
                    
                }
            }
        }
        //let userID = Auth.auth().currentUser?.uid
//        ref = Database.database().reference().child("Banners")
//        ref.observe(.value, with: { snapshot in
//            print("print" + "\(snapshot.childrenCount)")
//            if (snapshot.childrenCount > 0){
//                
//                //creating data
//                
//                let value = snapshot.value as? NSDictionary
//                let id = value?["id"] as? Int ?? 0
//                let name = value?["name"] as? String ?? ""
//                let photourl = value?["photourl"] as? String ?? ""
//                let idBarraca = value?["idBarraca"] as? Int ?? 0
//
//            
//                let bannner = Banners(name: name, id:id ,photourl:photourl,idBarraca:idBarraca,ref: snapshot.ref)
//                self.banners.append(bannner)
//            }
//
//                else {
//                    let alertController = UIAlertController(title: "Alert", message: "This qr is not valid, if its a mistake please call your vet!.", preferredStyle: .alert)
//                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
//                        print("Cancel button tapped");
//                    }
//                    alertController.addAction(cancelAction)
//                }
//            }
//            )

    }
    
    
    


}
