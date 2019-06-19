//
//  PhotoShootOrLibraryViewController.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 6/19/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit

class PhotoShootOrLibraryViewController: UIViewController , UINavigationControllerDelegate {
    
    @IBOutlet weak var libraryButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    var image = UIImage()
    var classifier = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func camaraButtonAction(_ sender: Any) {
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            return
        }
        
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .camera
        cameraPicker.allowsEditing = false
        
        present(cameraPicker, animated: true)
    }
    
    
    @IBAction func libraryButtonAction(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    

}


extension PhotoShootOrLibraryViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
