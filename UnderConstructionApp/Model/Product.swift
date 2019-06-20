//
//  Product.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 6/17/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import Foundation

class Product {
    var id : Int
    var name : String
    var photourl : String
    var category : String
    var details : String
    var price : Double
    
    init(id:Int,name:String,photourl:String,category : String, details : String, price : Double) {
        self.id = id
        self.name = name
        self.photourl = photourl
        self.category = category
        self.details = details
        self.price = price
    }
    
}
