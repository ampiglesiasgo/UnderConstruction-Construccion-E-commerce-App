//
//  Barraca.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 6/17/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import Foundation

class Barraca {
    var id : Int
    var name : String
    var photourl : String
    var address : String
    var details : String
    var products : [Product]
    
    init(id:Int,name:String,photourl:String,address : String, details : String, products : [Product]) {
        self.id = id
        self.name = name
        self.photourl = photourl
        self.address = address
        self.details = details
        self.products = products
    }
    
}
