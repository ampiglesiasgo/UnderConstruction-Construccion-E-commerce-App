//
//  ProductFinalDetailsViewController.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 6/27/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit

class ProductFinalDetailsViewController: UIViewController {
    @IBOutlet weak var productUnitPicker: UIPickerView!
    @IBOutlet weak var productQuantityLabel: UILabel!
    @IBOutlet weak var messageTextField: UITextView!
    @IBOutlet weak var buttonPlusView: UIView!
    @IBOutlet weak var addToCartButton: UIButton!
    
    let pickerData = ["Unidad","por m2","Caja","Balde"]
    var unitSelected = "Unidad"
    var product = Product(id:0,name:"",photourl:"",category : "", details : "", price : 0, photoGallery : [String]())
    var barracaViewController:BarracaViewController?



    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HideKeyboard()
        messageTextField.delegate = self
        messageTextField.text = "Deje su comentario..."
        messageTextField.textColor = UIColor.lightGray

        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        messageTextField.layer.borderColor = UIColor.black.cgColor
        messageTextField.layer.borderWidth = 1
        messageTextField.layer.masksToBounds = true
        messageTextField.layer.cornerRadius = 12
        addToCartButton.layer.cornerRadius = 15
        addToCartButton.clipsToBounds = true
        buttonPlusView.layer.cornerRadius = 15
        buttonPlusView.clipsToBounds = true
        

    }
    func configureShoppingItem() -> ShoppingCartItem {
        let shoppingCartItem = ShoppingCartItem(product: product)
        shoppingCartItem.quantity = Int(productQuantityLabel.text!) ?? 0
        shoppingCartItem.unit = unitSelected
        shoppingCartItem.comments = messageTextField.text
        return shoppingCartItem
        
    }
    
    
    @IBAction func addItemToChartButtonAction(_ sender: Any) {
        let shoppingCartItem = configureShoppingItem()
        barracaViewController?.shopingCartList.append(shoppingCartItem)
        self.navigationController!.popToViewController(barracaViewController!, animated: true)
        
    }
    
    
    
    @IBAction func ButtonPlusAction(_ sender: Any) {
        var quantity = Int(productQuantityLabel.text!)
        quantity = quantity! + 1
        productQuantityLabel.text = String(quantity!)
        
    }
    
    @IBAction func ButtonMinusAction(_ sender: Any) {
        var quantity = Int(productQuantityLabel.text!)
        quantity = quantity! - 1
        productQuantityLabel.text = String(quantity!)
    }

}


extension ProductFinalDetailsViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        unitSelected = pickerData[row]
    }
}

extension ProductFinalDetailsViewController {
    
    func HideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self , action: #selector(DismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
    
    
}

extension ProductFinalDetailsViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if messageTextField.textColor == UIColor.lightGray {
            messageTextField.text = nil
            messageTextField.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if messageTextField.text.isEmpty {
            messageTextField.text = "Deje su comentario..."
            messageTextField.textColor = UIColor.lightGray
        }
    }
    
    
}
