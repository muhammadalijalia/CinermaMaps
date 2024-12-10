//
//  HomeViewModel.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 31/08/24.
//

import Foundation
import UIKit
import LanguageManager_iOS

class HomeViewModel {
    
    var fetchSuccessfully:(() -> Void)?
    var arrayUserProfile: Res_UserProfile!
    
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
    
    func fetchUserProfileDetails(vC: UIViewController)
    {
        Api.shared.requestUserProfile(vC) { responseData in
            self.arrayUserProfile = responseData
            self.fetchSuccessfully?()
        }
    }
}

extension HomeViewModel {
    
    func navigateToSettingViewController(from navigationController: UINavigationController?) {
        let vC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        navigationController?.pushViewController(vC, animated: true)
    }
    
    func navigateToTripViewController(from navigationController: UINavigationController?) {
        let vC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TripScheduleVC") as! TripScheduleVC
        navigationController?.pushViewController(vC, animated: true)
    }
    
    func navigateToNotificationViewController(from navigationController: UINavigationController?) {
        let vC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotifyVC") as! NotifyVC
        navigationController?.pushViewController(vC, animated: true)
    }
    
    func navigateToGuidlineViewController(from navigationController: UINavigationController?,title: String, dateTime: String, description: String, image: String) {
        let vC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GuidelinesVC") as! GuidelinesVC
        vC.titleVal = title
        vC.dateTime = dateTime
        vC.descriptionVal = description
        vC.placeImg = image
        navigationController?.pushViewController(vC, animated: true)
    }
    
    func navigateToServicesViewController(from navigationController: UINavigationController?, service_Id: String) {
        let vC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ServiceDetailVC") as! ServiceDetailVC
        vC.viewModel.service_ID = service_Id
        navigationController?.pushViewController(vC, animated: true)
    }
    
    func navigateToCityMapsViewController(from navigationController: UINavigationController?, countryId: String) {
        let vC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CityMapsVC") as! CityMapsVC
        vC.viewModel.country_ID = countryId
        navigationController?.pushViewController(vC, animated: true)
    }
}
