//
//  MapViewModel.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 03/09/24.
//

import Foundation
import LanguageManager_iOS

class MapViewModel {
    
    public func setupSearchBar(for search_Bar: UISearchBar) {
        search_Bar.placeholder = "Search".localiz()
        search_Bar.barTintColor = UIColor.white
        search_Bar.searchTextField.backgroundColor = UIColor.white
        search_Bar.searchTextField.textColor = UIColor.black
        
        if let clearButton = search_Bar.searchTextField.value(forKey: "_clearButton") as? UIButton {
            clearButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        }
        
        search_Bar.layer.cornerRadius = 10
        search_Bar.layer.masksToBounds = true
    }
    
    func navigateToCityMapsViewController(from navigationController: UINavigationController?, countryId: String, countryName: String) {
        let vC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CityMapsVC") as! CityMapsVC
        vC.viewModel.country_ID = countryId
        vC.countryName = countryName
        navigationController?.pushViewController(vC, animated: true)
    }
}
