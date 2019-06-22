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
        // [START setup]


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
//        if Auth.auth().currentUser != nil {
//            print("Usuario " + "\(Auth.auth().currentUser?.email)")
//            self.performSegue(withIdentifier: "startToHomeSegue", sender: self)
//        }
    }
    
    @IBAction func logInStartAction(_ sender: Any) {
        performSegue(withIdentifier: "startToLoginSegue", sender: self)

    }
    
    @IBAction func registerStartAction(_ sender: Any) {
        performSegue(withIdentifier: "startToRegisterSegue", sender: self)

    }
}
