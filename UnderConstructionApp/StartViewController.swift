//
//  StartViewController.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 6/9/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit
import FirebaseAuth

class StartViewController: UIViewController {

    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "startToHomeSegue", sender: self)
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "toRegisterSegue"{
//            let registerViewController = (segue.destination as! RegisterViewController)
//
//        }
//        if segue.identifier == "loginToHomeSegue"{
//            let homeViewController = (segue.destination as! HomeViewController)
//
//        }
//    }

    
    @IBAction func logInStartAction(_ sender: Any) {
        performSegue(withIdentifier: "startToLoginSegue", sender: self)

    }
    
    @IBAction func registerStartAction(_ sender: Any) {
        performSegue(withIdentifier: "startToRegisterSegue", sender: self)

    }
}
