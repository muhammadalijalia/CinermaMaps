//
//  AdvertisementViewModel.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 15/11/24.
//

import Foundation

class AdvertisementViewModel {
    
    var arrayOfBanners: [Res_Banner] = []
    var fetchedSuccessfully:(() -> Void)?
    
    func requestToFetchAdvertisement(vC: UIViewController)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        
        Api.shared.requestToAdvertismentBanner(vC, paramDict) { responseData in
            if responseData.count > 0 {
                self.arrayOfBanners = responseData
            } else {
                self.arrayOfBanners = []
            }
            self.fetchedSuccessfully?()
        }
    }
}
