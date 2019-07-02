//
//  UserDataViewController.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 7/1/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class UserDataViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!

    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var addressTextLabel: UILabel!
    @IBOutlet weak var phoneTextLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var connectedUser = Auth.auth().currentUser
    var db: Firestore!


    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        nameTextField.delegate = self
        addressTextField.delegate = self
        phoneTextField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        saveButton.isHidden = false
        editButton.isHidden = true
        emailLabel.text = connectedUser?.email
        if (ModelManager.shared.users.contains(where: { $0.email == connectedUser?.email })){
            if let i = ModelManager.shared.users.firstIndex(where: {$0.email == connectedUser?.email}) {
                let user = ModelManager.shared.users[i]
                if !(user.username == ""){
                    nameLabel.text = user.username
                }
                else { nameLabel.text = "" }
                if !(user.name == "") {
                    nameTextLabel.isHidden = false
                    nameTextField.isHidden = true
                    nameTextLabel.text = user.name
                    nameTextField.text = user.name
                    saveButton.isHidden = true
                    editButton.isHidden = false
                }
                if !(user.address == "") {
                    addressTextLabel.isHidden = false
                    addressTextField.isHidden = true
                    addressTextLabel.text = user.address
                    addressTextField.text = user.address
                }
                if !(user.phone == "") {
                    phoneTextLabel.isHidden = false
                    phoneTextField.isHidden = true
                    phoneTextLabel.text = user.phone
                    phoneTextField.text = user.phone
                }
            }
        }
        
            if nameTextField.text!.isEmpty {
                nameTextLabel.isHidden = true
                nameTextField.isHidden = false
                saveButton.isHidden = false
                editButton.isHidden = true
                
            }
            if addressTextField.text!.isEmpty {
                addressTextLabel.isHidden = true
                addressTextField.isHidden = false
                }
            if phoneTextField.text!.isEmpty {
                    phoneTextLabel.isHidden = true
                    phoneTextField.isHidden = false
                }
        
    }
    
    @IBAction func editDataButton(_ sender: Any) {
        nameTextLabel.isHidden = true
        nameTextField.isHidden = false
        addressTextLabel.isHidden = true
        addressTextField.isHidden = false
        phoneTextLabel.isHidden = true
        phoneTextField.isHidden = false
        saveButton.isHidden = false
        editButton.isHidden = true

    }
    
    
    
    @IBAction func LogOutButtonAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
    }
    
    
    @IBAction func saveButtonAction(_ sender: Any) {
        nameTextLabel.isHidden = false
        nameTextField.isHidden = true
        addressTextLabel.isHidden = false
        addressTextField.isHidden = true
        phoneTextLabel.isHidden = false
        phoneTextField.isHidden = true
        
        nameTextLabel.text = nameTextField.text
        addressTextLabel.text = addressTextField.text
        phoneTextLabel.text = phoneTextField.text
        
        saveButton.isHidden = true
        editButton.isHidden = false
        
        if (ModelManager.shared.users.contains(where: { $0.email == connectedUser?.email })){
            if let i = ModelManager.shared.users.firstIndex(where: {$0.email == connectedUser?.email}) {
                let user = ModelManager.shared.users[i]
                user.name = nameTextField.text!
                user.address = addressTextField.text!
                user.phone = phoneTextField.text!
                var documentId = ""
                db.collection("users").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        var useremail = ""
                        for document in querySnapshot!.documents {
                            let bannerData = document.data()
                            for data in bannerData{
                                if data.key == "useremail"{
                                    useremail = data.value as! String
                                    if useremail == self.connectedUser?.email{
                                        documentId = document.documentID
                                        break
                                    }
                                }

                            }
                        if !(documentId == ""){break}
                        }
                        
                        let userData = self.db.collection("users").document(documentId)
                        userData.updateData([
                            "userRealName": user.name,
                            "userAddress" : user.address,
                            "userPhone" : user.phone
                        ]) { err in
                            if let err = err {
                                print("Error updating document: \(err)")
                            } else {
                                print("Document successfully updated")
                            }
                        }
                    }
                }
            }
    
    }
}
}

extension UserDataViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
