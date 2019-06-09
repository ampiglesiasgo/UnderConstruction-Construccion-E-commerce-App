//
//  ViewController.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 6/7/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var loginBackView: UIView!
    @IBOutlet weak var loginEmailTextField: UITextField!
    @IBOutlet weak var loginPasswordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillLayoutSubviews() {
        loginBackView.backgroundColor = .white
        loginBackView.dropShadow(color: .gray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        loginButton.layer.cornerRadius = 15
        loginButton.clipsToBounds = true
        loginEmailTextField.layer.cornerRadius = 15
        loginEmailTextField.clipsToBounds = true
        loginPasswordTextField.layer.cornerRadius = 15
        loginPasswordTextField.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Send data to the toRegisterSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toRegisterSegue"{
            let registerViewController = (segue.destination as! RegisterViewController)

        }
        if segue.identifier == "loginToHomeSegue"{
            let homeViewController = (segue.destination as! HomeViewController)
            
        }
    }
    
    
    @IBAction func singUpButton(_ sender: Any) {
        performSegue(withIdentifier: "toRegisterSegue", sender: self)
    }
    
    
    @IBAction func loginActionButton(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: loginEmailTextField.text!, password: loginPasswordTextField.text!) { (user, error) in
            if error == nil{
                self.performSegue(withIdentifier: "loginToHomeSegue", sender: self)
            }
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }

}

extension UIView {
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        layer.cornerRadius = 8
    }
}
