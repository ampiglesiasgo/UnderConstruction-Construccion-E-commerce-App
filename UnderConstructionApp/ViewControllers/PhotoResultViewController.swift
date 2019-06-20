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
    
    @IBOutlet weak var buyProductButton: UIButton!
    
    
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
        buyProductButton.isHidden = true
        Translation.shared.Translate(phrase: classifierResult, toLang: "es") { (translate) in
            DispatchQueue.main.async {
                self.classificationLabel.isHidden = false
                self.buyProductButton.isHidden = false
                self.classificationLabel.text = "Creo que es un/a \(translate)."
                self.classifierResult = translate
                self.photoResultaImageView.image = self.photoImageResult
                self.photoResultActivityIndicator.stopAnimating()
                self.photoResultActivityIndicator.isHidden = true
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        buyProductButton.layer.cornerRadius = 15
        buyProductButton.clipsToBounds = true

    }
    
    
    @IBAction func buyProductActionButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "buyProductSegue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "buyProductSegue"{
            let barracasTableViewController = (segue.destination as! BarracasTableViewController)
            barracasTableViewController.classifierResult = classifierResult


        }
    }


}
