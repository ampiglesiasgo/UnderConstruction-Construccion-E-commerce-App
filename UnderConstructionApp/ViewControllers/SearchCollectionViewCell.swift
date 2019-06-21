//
//  SearchCollectionViewCell.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 6/12/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import UIKit

protocol SearchCollectionViewCellDelegate {
    func didTapSearchBar(cell: SearchCollectionViewCell, searchText : String)
}

class SearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionSearchBar: UISearchBar!
    var delegate : SearchCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        collectionSearchBar.delegate = self
    }

}



extension SearchCollectionViewCell : UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        self.delegate?.didTapSearchBar(cell : self, searchText: searchBar.text!)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if collectionSearchBar.text == nil || collectionSearchBar.text == ""
        {
            //Text control to stop waiting for input – which in turn dismisses the keyboard
            collectionSearchBar.perform(#selector(self.resignFirstResponder), with: nil, afterDelay: 0.1)
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        collectionSearchBar.endEditing(true)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        collectionSearchBar.endEditing(true)
    }

}
