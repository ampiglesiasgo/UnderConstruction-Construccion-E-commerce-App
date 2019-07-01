//
//  ShippingDataViewController.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 7/1/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit
import FirebaseAuth

class ShippingDataViewController: UIViewController {

    @IBOutlet weak var shippingNameTextField: UITextField!
    
    @IBOutlet weak var shippingAddressTextField: UITextField!
    
    @IBOutlet weak var shippingPhoneTextField: UITextField!
    
    @IBOutlet weak var shippingDatePicker: UIDatePicker!
    
    @IBOutlet weak var saveDataButton: UIButton!
    
    var purchase = Purchase()
    var shoppingCartList = [ShoppingCartItem]()
    var barracaViewController:BarracaViewController?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.shippingNameTextField.delegate = self
        self.shippingAddressTextField.delegate = self
        self.shippingPhoneTextField.delegate = self

    }
    
    override func viewWillLayoutSubviews() {
        saveDataButton.layer.cornerRadius = 15
        saveDataButton.clipsToBounds = true
    }
    
    @IBAction func dataPickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: shippingDatePicker.date)
        purchase.shippingDate = strDate
    }
    
    @IBAction func sendPurchaseDataButtonAction(_ sender: Any) {
        if shippingNameTextField.text!.isEmpty || shippingPhoneTextField.text!.isEmpty || shippingAddressTextField.text!.isEmpty {
            let alertController = UIAlertController(title: "Alerta", message: "Debe rellenar todos los campos", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: .none))
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            purchase.shippingName = shippingNameTextField.text!
            purchase.shoppingCartList = shoppingCartList
            purchase.shippingAddress = shippingAddressTextField.text!
            purchase.shippingPhone = shippingPhoneTextField.text!
            purchase.shippingUser = (Auth.auth().currentUser?.email)!
            shoppingCartList = [ShoppingCartItem]()
            barracaViewController?.shopingCartList = shoppingCartList
            self.performSegue(withIdentifier: "toFinishView", sender: self)
        }

    }
    
    
}

extension ShippingDataViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
