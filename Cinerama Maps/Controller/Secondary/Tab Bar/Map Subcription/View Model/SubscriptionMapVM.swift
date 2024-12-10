//
//  SubscriptionMapViewModel.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 04/11/24.
//

import Foundation

class SubscriptionMapViewModel {
    
    var arrayOfPlaceDetails: [Place_details] = []
    var fetchedSuccessfully:(() -> Void)?
    
    var cityId:String = ""
    var cityName:String = ""
    
    func requestCountryMapDetails(vC: UIViewController)
    {
        var param: [String : AnyObject] = [:]
        param["city_id"] = cityId as AnyObject
        
        print(param)
        
        Api.shared.requestCityPlaceDt(vC, param) { responseData in
            DispatchQueue.global(qos: .utility).async {
                self.cityName = responseData.name ?? ""
                if let resPlaceDetails = responseData.place_details {
                    if resPlaceDetails.count > 0 {
                        self.arrayOfPlaceDetails = resPlaceDetails
                    } else {
                        self.arrayOfPlaceDetails = []
                    }
                }
                DispatchQueue.main.async {
                    self.fetchedSuccessfully?()
                }
            }
        }
    }
    
    func requestToFavUnfavPlace(vC: UIViewController, placeId:String, status: String)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["place_id"] = placeId as AnyObject
        paramDict["status"] = status as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToSelectFavUnFavPlace(vC, paramDict) { [self] responseData in
            if responseData.status == "1" {
                self.fetchedSuccessfully?()
            } else {
                print("Api message: \(responseData.message ?? "")")
            }
        }
    }
    
    func navigateToGooglePlaceDetailViewController(from navigationController: UINavigationController,cityAddress: String, cityPlaceId: String, cityAddressLat: String, cityAddressLon: String) {
        let vC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GooglePlaceDetailVC") as! GooglePlaceDetailVC
        vC.viewModel.place_Id = cityPlaceId
        vC.viewModel.val_Address = cityAddress
        vC.viewModel.lat = cityAddressLat
        vC.viewModel.lon = cityAddressLon
        navigationController.pushViewController(vC, animated: true)
    }
}
