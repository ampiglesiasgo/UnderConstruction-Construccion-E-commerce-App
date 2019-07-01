//
//  ShippingDataViewController.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 7/1/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit

class ShippingDataViewController: UIViewController {

    @IBOutlet weak var shippingNameTextField: UITextField!
    
    @IBOutlet weak var shippingAddressTextField: UITextField!
    
    @IBOutlet weak var shippingPhoneTextField: UITextField!
    
    @IBOutlet weak var shippingDatePicker: UIDatePicker!
    
    @IBOutlet weak var saveDataButton: UIButton!
    
    var purchase = Purchase()
    var shoppingCartList = [ShoppingCartItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
