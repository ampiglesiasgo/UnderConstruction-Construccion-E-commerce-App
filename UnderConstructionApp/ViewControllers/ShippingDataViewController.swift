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
        self.shippingNameTextField.delegate = self
        self.shippingAddressTextField.delegate = self
        self.shippingPhoneTextField.delegate = self

    }
    
    @IBAction func dataPickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: shippingDatePicker.date)
        purchase.shippingDate = strDate
    }
    
    @IBAction func sendPurchaseDataButtonAction(_ sender: Any) {
        purchase.shippingName = shippingNameTextField.text!
        purchase.shoppingCartList = shoppingCartList
        purchase.shippingAddress = shippingAddressTextField.text!
        purchase.shippingPhone = shippingPhoneTextField.text!
        self.performSegue(withIdentifier: "toFinishView", sender: self)

    }
    
    
}

extension ShippingDataViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
