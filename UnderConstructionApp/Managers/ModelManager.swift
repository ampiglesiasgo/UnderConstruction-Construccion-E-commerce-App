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
    var categories = [Category]()
    var barracas = [Barraca]()
    var productos = [Product]()
    var filteredBarracas = [Barraca]()

    
    


}
