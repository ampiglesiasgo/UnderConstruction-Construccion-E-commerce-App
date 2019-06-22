//
//  BarracasTableViewController.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 6/16/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class BarracasTableViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate
{
    
    @IBOutlet weak var barracasTableView: UITableView!
    var db: Firestore!
    var classifierResult = ""
    var filterBarracas = false
    var filterCategory = ""



    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getBarraca(db: db) { (finishBarraca) in
            if finishBarraca{
                self.barracasTableView.reloadData()            }
        }
    }
    
    
    func getBarraca(db : Firestore, completionHandler: @escaping (Bool) -> Void){
        var result = false
        db.collection("Barracas").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completionHandler(result)
            } else {
                var id = 0
                var name = ""
                var photourl = ""
                var address = ""
                var details = ""
                var products = [Product]()
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
                        if data.key == "address"{
                            address = data.value as! String
                        }
                        if data.key == "details"{
                            details = data.value as! String
                        }
                        if data.key == "products"{
                            let dataProductList = data.value as! NSArray
                            for dataProduct in dataProductList
                            {
                                let data = dataProduct as! NSDictionary
                                let id_prod = data.value(forKey: "id") as! Int
                                let prod = Product(id: data.value(forKey: "id") as! Int,
                                                   name:data.value(forKey: "name") as! String,
                                                   photourl:data.value(forKey: "photourl") as! String,
                                                   category : data.value(forKey: "category") as! String,
                                                   details : data.value(forKey: "details") as! String,
                                                   price : data.value(forKey: "price") as! Double)
                                products.append(prod)
                                if !(ModelManager.shared.productos.contains(where: { $0.id == id_prod })){
                                    ModelManager.shared.productos.append(prod)
                                    
                                }
                            }
                        }
                        
                        }
                    if !(ModelManager.shared.barracas.contains(where: { $0.id == id })){
                        let barraca = Barraca(id:id,name:name,photourl:photourl,address : address, details : details, products : products)
                        
                        ModelManager.shared.barracas.append(barraca)
                        
                        products = [Product]()
                        }
                    }
                result = true
                ModelManager.shared.filteredBarracas = [Barraca]()
                for b in ModelManager.shared.barracas {
                    for p in b.products{
                        if !(self.classifierResult == ""){
                            if p.name.uppercased().contains(self.classifierResult.uppercased()){
                                if b.products.contains(where: { $0.id == p.id }){
                                    ModelManager.shared.filteredBarracas.append(b)
                                }
                            }
                        self.filterBarracas = true
                        }
                        if !(self.filterCategory == ""){
                            if p.category.uppercased().contains(self.filterCategory.uppercased()){
                                //for b in ModelManager.shared.barracas {
                                    if b.products.contains(where: { $0.id == p.id }){
                                        ModelManager.shared.filteredBarracas.append(b)
                                    }
                                }
                            self.filterBarracas = true
                            
                        }
                    }
                }
               self.filterCategory = ""
               self.classifierResult = ""
                completionHandler(result)
                }
        }
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filterBarracas{
           return ModelManager.shared.filteredBarracas.count
        }
        return ModelManager.shared.barracas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "barracaCell", for : indexPath) as! BarracasTableViewCell

        if filterBarracas{
            let barraca =  ModelManager.shared.filteredBarracas[indexPath.row]
            cell.barracaNameLabel.text = barraca.name
            cell.barracaAddressLabel.text = barraca.address
            cell.barracaDetailsLabel.text = barraca.details
            cell.barracasPhotoImageView.kf.setImage(with: URL(string: barraca.photourl))
        }
        else {
            let barraca = ModelManager.shared.barracas[indexPath.row]
            cell.barracaNameLabel.text = barraca.name
            cell.barracaAddressLabel.text = barraca.address
            cell.barracaDetailsLabel.text = barraca.details
            cell.barracasPhotoImageView.kf.setImage(with: URL(string: barraca.photourl))
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }


}

