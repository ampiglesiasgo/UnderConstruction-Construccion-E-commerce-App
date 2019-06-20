//
//  PhotoResultViewController.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 6/19/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit

class PhotoResultViewController: UIViewController {

    @IBOutlet weak var photoResultaImageView: UIImageView!
    @IBOutlet weak var classificationLabel: UILabel!
    
    @IBOutlet weak var photoResultActivityIndicator: UIActivityIndicatorView!

    
    var photoImageResult = UIImage()
    var classifierResult = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        photoResultActivityIndicator.startAnimating()
        classificationLabel.isHidden = true
        Translation.shared.Translate(phrase: classifierResult, toLang: "es") { (translate) in
            DispatchQueue.main.async {
                self.classificationLabel.isHidden = false
                self.classificationLabel.text = translate
                self.photoResultaImageView.image = self.photoImageResult
                self.photoResultActivityIndicator.stopAnimating()
                self.photoResultActivityIndicator.isHidden = true
            }

            
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
