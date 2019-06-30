//
//  ShoppingCartItem.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 6/30/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import Foundation

class ShoppingCartItem {
    
    var quantity : Int = 1
    var product : Product
    var subTotal : Double { get { return product.price * Double(quantity) } }
    var unit = ""
    var comments = "" 
    
    
    init(product: Product) {
        self.product = product
    }
    
}
