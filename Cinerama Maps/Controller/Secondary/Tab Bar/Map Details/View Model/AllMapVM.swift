//
//  AllMapViewMode.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 05/09/24.
//

import Foundation

class AllMapViewModel {
    
    var arrayOfDetailCityMaps: Res_CityPlaceDetails!
    var arrayOfReviews: [Rating_review] = []
    var arrayOfPlaceImg: [Places_images] = []
    var fetchedSuccessfully:(() -> Void)?
    
    var cityId: String = ""
    
    func navigateToSubcribeViewController(from navigationController: UINavigationController?, mapiD:String, type: String, durationVal: String, amountVal: String) {
        let vC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PaymentVC") as! PaymentVC
        vC.viewModel.countryMapiD = mapiD
        vC.viewModel.countryCityiD = cityId
        vC.typeVal = type
        vC.duration = durationVal
        vC.totalPaidAmount = amountVal
        navigationController?.pushViewController(vC, animated: true)
    }
    
    func returnBackk(from navigationController: UINavigationController?) {
        navigationController?.popViewController(animated: true)
    }
    
    func requestCountryMapDetails(vC: UIViewController)
    {
        var param: [String : AnyObject] = [:]
        param["city_id"] = cityId as AnyObject
        
        print(param)
        
        Api.shared.requestCityPlaceDt(vC, param) { responseData in
            self.arrayOfDetailCityMaps = responseData
            self.arrayOfReviews = responseData.rating_review ?? []
            self.arrayOfPlaceImg = responseData.places_images ?? []
            self.fetchedSuccessfully?()
        }
    }
    
    func fetchFavAndUnFavMap(vC: UIViewController)
    {
        var param: [String : AnyObject] = [:]
        param["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        param["city_id"] = cityId as AnyObject
        
        print(param)
        
        Api.shared.requestToSelectFavUnFavCityMap(vC, param) { responseData in
            if responseData.status == "1" {
                self.fetchedSuccessfully?()
            } else {
                print(responseData.message ?? "")
            }
        }
    }
}
