//
//  StartViewController.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 6/9/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class StartViewController: UIViewController {

    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var startActivityIndicator: UIActivityIndicatorView!
    var db: Firestore!

    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        // Do any additional setup after loading the view.
    }
    override func viewWillLayoutSubviews() {
        logInButton.layer.cornerRadius = 15
        logInButton.clipsToBounds = true
        registerButton.layer.cornerRadius = 15
        registerButton.clipsToBounds = true
    }

    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        startActivityIndicator.startAnimating()
        logInButton.isHidden = true
        registerButton.isHidden = true
        if Auth.auth().currentUser != nil {
            let user = User()
            user.email = (Auth.auth().currentUser?.email)!
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
                self.startActivityIndicator.stopAnimating()
                self.startActivityIndicator.isHidden = true
                self.logInButton.isHidden = false
                self.registerButton.isHidden = false
            self.performSegue(withIdentifier: "startToHomeSegue", sender: self)
        }
        }
        else {
            self.startActivityIndicator.stopAnimating()
            self.startActivityIndicator.isHidden = true
            self.logInButton.isHidden = false
            self.registerButton.isHidden = false
        }

        
    }
    
    @IBAction func logInStartAction(_ sender: Any) {
        performSegue(withIdentifier: "startToLoginSegue", sender: self)

    }
    
    @IBAction func registerStartAction(_ sender: Any) {
        performSegue(withIdentifier: "startToRegisterSegue", sender: self)

    }
}
