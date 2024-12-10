//
//  CityViewModel.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 03/09/24.
//

import Foundation
import LanguageManager_iOS

class CityViewModel {
    
    var country_ID: String = ""
    var arrayOfDetailCityMap: [Res_CityMap] = []
    
    var requestSuccessfull:(() -> Void)?
    
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
    
    func navigateToCityMapsDetailViewController(from navigationController: UINavigationController?, cityId: String, isSubscribed: String) {
        print(isSubscribed)
//        if isSubscribed == "Yes" {
//            let vC = R.storyboard.main().instantiateViewController(withIdentifier: "SubscriptionMapVC") as! SubscriptionMapVC
//            vC.viewModel.cityId = cityId
//            navigationController?.pushViewController(vC, animated: true)
//        } else {
//
//        }
        let vC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AllMapsDetailVC") as! AllMapsDetailVC
        vC.viewModel.cityId = cityId
        vC.isSubscribed = isSubscribed
        navigationController?.pushViewController(vC, animated: true)
    }
    
    func returnBackk(from navigationController: UINavigationController?) {
        navigationController?.popViewController(animated: true)
    }
    
    func requestCityMapDetails(vC: UIViewController)
    {
        var param: [String : AnyObject] = [:]
        param["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        param["country_id"] = country_ID as AnyObject
        
        print(param)
        
        Api.shared.requestCityMap(vC, param) { responseData in
            if responseData.count > 0 {
                self.arrayOfDetailCityMap = responseData
            } else {
                self.arrayOfDetailCityMap = []
            }
            self.requestSuccessfull?()
        }
    }
    
    func fetchFavAndUnFavMap(vC: UIViewController, cityId: String)
    {
        var param: [String : AnyObject] = [:]
        param["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        param["city_id"] = cityId as AnyObject
        
        print(param)
        
        Api.shared.requestToSelectFavUnFavCityMap(vC, param) { responseData in
            if responseData.status == "1" {
                self.requestSuccessfull?()
            } else {
                print(responseData.message ?? "")
            }
        }
    }
}
