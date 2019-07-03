//
//  ProductPhotoCollectionViewCell.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 6/25/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit

class ProductPhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    var isZooming = false
    var originalImageCenter:CGPoint?
    
    override func awakeFromNib() {
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(self.pinch(sender:)))
        pinch.delegate = self
        self.productImage.addGestureRecognizer(pinch)
        productImage.isUserInteractionEnabled = true

    }
    
    
    @objc func pinch(sender:UIPinchGestureRecognizer) {
        
        if sender.state == .began {
            let currentScale = self.productImage.frame.size.width / self.productImage.bounds.size.width
            let newScale = currentScale*sender.scale
            
            if newScale > 1 {
                self.isZooming = true
            }
        } else if sender.state == .changed {
            
            guard let view = sender.view else {return}
            
            let pinchCenter = CGPoint(x: sender.location(in: view).x - view.bounds.midX,
                                      y: sender.location(in: view).y - view.bounds.midY)
            let transform = view.transform.translatedBy(x: pinchCenter.x, y: pinchCenter.y)
                .scaledBy(x: sender.scale, y: sender.scale)
                .translatedBy(x: -pinchCenter.x, y: -pinchCenter.y)
            
            let currentScale = self.productImage.frame.size.width / self.productImage.bounds.size.width
            var newScale = currentScale*sender.scale
            
            if newScale < 1 {
                newScale = 1
                let transform = CGAffineTransform(scaleX: newScale, y: newScale)
                self.productImage.transform = transform
                sender.scale = 1
            }else {
                view.transform = transform
                sender.scale = 1
            }
            
        } else if sender.state == .ended || sender.state == .failed || sender.state == .cancelled {
            
            guard let center = self.originalImageCenter else {return}
            
            UIView.animate(withDuration: 0.3, animations: {
                self.productImage.transform = CGAffineTransform.identity
                self.productImage.center = center
            }, completion: { _ in
                self.isZooming = false
            })
        }
        
    }
}

extension ProductPhotoCollectionViewCell : UIGestureRecognizerDelegate {}
