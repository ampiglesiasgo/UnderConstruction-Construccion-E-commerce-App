//
//  ViewController.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 6/7/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var loginBackView: UIView!
    @IBOutlet weak var loginEmailTextField: UITextField!
    @IBOutlet weak var loginPasswordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    var db: Firestore!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.HideKeyboard()
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()


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

    
    
    @IBAction func singUpButton(_ sender: Any) {
        performSegue(withIdentifier: "toRegisterSegue", sender: self)
    }
    
    
    @IBAction func loginActionButton(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: loginEmailTextField.text!, password: loginPasswordTextField.text!) { (user, error) in
            if error == nil{
                let user = User()
                user.email = self.loginEmailTextField.text!
                self.db.collection("users").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            let userData = document.data()
                            if (userData.contains(where: { $0.value as! String == user.email })){
                                for data in userData{
                                    if data.key == "username"{
                                        user.username = data.value as! String
                                    }
                                    if data.key == "userRealName"{
                                        user.name = data.value as! String
                                    }
                                    if data.key == "userAddress"{
                                        user.address = data.value as! String
                                    }
                                    if data.key == "userPhone"{
                                        user.phone = data.value as! String
                                    }
                                }
                
                                ModelManager.shared.users.append(user)
                                break
                            }
                        }
                }
                
                self.performSegue(withIdentifier: "loginToHomeSegue", sender: self)
            }
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

extension ViewController {
    
    func HideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self , action: #selector(DismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
    
    
}



