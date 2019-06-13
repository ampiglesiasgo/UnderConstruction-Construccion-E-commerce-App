//
//  Category.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 6/12/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import Foundation

class Category {
    var id : Int
    var name : String
    var photourl : String
    
    init(id:Int,name:String,photourl:String) {
        self.id = id
        self.name = name
        self.photourl = photourl
    }
}
