//
//  OfferViewModel.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 05/09/24.
//

import Foundation

class OfferViewModel {
    
    var arrayOfOffers: [Res_Offers] = []
    var fetchedSuccessfully:(() -> Void)?
    
     func setupSearchBar(searchBar: UISearchBar!) {
        searchBar.placeholder = "Search"
        searchBar.barTintColor = UIColor.white
        searchBar.searchTextField.backgroundColor = UIColor.white
        searchBar.searchTextField.textColor = UIColor.black
        
        if let clearButton = searchBar.searchTextField.value(forKey: "_clearButton") as? UIButton {
            clearButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        }
        
        searchBar.layer.cornerRadius = 10
        searchBar.layer.masksToBounds = true
    }
    
    
    func requestCompanyOffer(vC: UIViewController) {
        Api.shared.requestCompanyOffers(vC) { responseData in
            if responseData.count > 0 {
                self.arrayOfOffers = responseData
            } else {
                self.arrayOfOffers = []
            }
            self.fetchedSuccessfully?()
        }
    }
}
