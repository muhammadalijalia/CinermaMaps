//
//  CountryMapViewModel.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 03/09/24.
//

import Foundation

class CountryMapApiViewModel {
    
    var arrayCountryMaps: [Res_CountryMap] = []
    var arrayFilteredCountryMaps: [Res_CountryMap] = []
    var fethcedSuccessfully:(() -> Void)?
    
    func fetchCountryMaps(vC: UIViewController)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["type"] = "All" as AnyObject
        
        Api.shared.requestCountryMap(vC, paramDict) { responseData in
            if responseData.count > 0 {
                self.arrayCountryMaps = responseData
                self.arrayFilteredCountryMaps = responseData
            } else {
                self.arrayCountryMaps = []
                self.arrayFilteredCountryMaps = []
            }
            self.fethcedSuccessfully?()
        }
    }
}
