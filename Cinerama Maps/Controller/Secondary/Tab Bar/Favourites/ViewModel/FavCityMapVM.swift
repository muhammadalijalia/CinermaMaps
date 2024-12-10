//
//  FavCityMapViewModel.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 24/10/24.
//

import Foundation

class FavCityMapViewModel {
    
    var arrayOfFavCityMap: [Res_FavCityMaps] = []
    var fetchedSuccessfull:(() -> Void)?
    
    func fetchFavCityMap(vC: UIViewController)
    {
        Api.shared.requestToFavCityMap(vC) { responseData in
            if responseData.count > 0 {
                self.arrayOfFavCityMap = responseData
            } else {
                self.arrayOfFavCityMap = []
            }
            self.fetchedSuccessfull?()
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
                self.fetchedSuccessfull?()
            } else {
                print(responseData.message ?? "")
            }
        }
    }
    
    func navigateToSubscriptionViewController(from navigation: UINavigationController?, cityId: String)
    {
        let vC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubscriptionMapVC") as! SubscriptionMapVC
        vC.viewModel.cityId = cityId
        navigation?.pushViewController(vC, animated: true)
    }
}
