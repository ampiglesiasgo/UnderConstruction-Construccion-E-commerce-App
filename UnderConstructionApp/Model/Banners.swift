//
//  Banners.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 6/11/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import Foundation
import Firebase

class Banners {
    var id: Int
    var name: String
    var photourl: String
    var idBarraca: Int
    
    init(name: String, id:Int ,photourl:String,idBarraca:Int  ) {
        self.id = id
        self.name = name
        self.photourl = photourl
        self.idBarraca = idBarraca
    }
    
//    init?(snapshot: DataSnapshot) {
//        
//        guard
//            let value = snapshot.value as? [String: AnyObject],
//            let id = value["id"] as? Int,
//            let name = value["name"] as? String,
//            let photourl = value["photourl"] as? String,
//            let idBarraca = value["idBarraca"] as? Int
//        else {
//                return nil
//        }
//        self.ref = snapshot.ref
//        self.id = id
//        self.name = name
//        self.photourl = photourl
//        self.idBarraca = idBarraca
//
//    }
//    
//    func toAnyObject() -> Any {
//        return [
//            "id": name,
//            "name": name,
//            "photourl": photourl,
//            "idBarraca": idBarraca
//        ]
//    }
//    
}


