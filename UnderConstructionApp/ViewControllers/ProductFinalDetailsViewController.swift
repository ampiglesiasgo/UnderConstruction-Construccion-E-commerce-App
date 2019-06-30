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
    
    let pickerData = ["Unidad","por m2","Caja","Balde"]
    var unitSelected = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        messageTextField.layer.borderColor = UIColor.black.cgColor
        messageTextField.layer.borderWidth = 1
        messageTextField.layer.masksToBounds = true
        messageTextField.layer.cornerRadius = 12

    }
    
    
    @IBAction func addItemToChartButtonAction(_ sender: Any) {
        //self.performSegue(withIdentifier: "toShoppingCart", sender: self)
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
        
    }
    
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "toShoppingCart"{
//            let shoppingCartViewController = (segue.destination as! ShoppingCartViewController)
//            //            productDetailsViewController.product = product
//
//
//        }
//    }

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
