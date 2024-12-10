//
//  MoreAboutTripVM.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 14/11/24.
//

import Foundation

class MoreAboutTripVM {
    
    var arrayOfMoreTrip: [Res_MoreAboutTrip] = []
    var fetchSuccessfully:(() -> Void)?
    
    var tableName:String = ""
    var cityiD:String = ""
    
    func fetchMoreAboutTrip(vC: UIViewController)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["city_id"] = cityiD as AnyObject
        paramDict["lat"] = k.emptyString as AnyObject
        paramDict["lon"] = k.emptyString as AnyObject
        paramDict["table_map_name"] = tableName as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToMoreAboutTrip(vC, paramDict) { responseData in
            if responseData.count > 0 {
                self.arrayOfMoreTrip = responseData
            } else {
                self.arrayOfMoreTrip = []
            }
            self.fetchSuccessfully?()
        }
    }
    
    func deleteTripSchedule(vC: UIViewController, cityiD: String)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["city_id"] = cityiD as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToDeleteCityTrip(vC, paramDict) { responseData in
            if responseData.status == "1" {
                self.fetchSuccessfully?()
            }
        }
     }
    
    func navigateToPlaceTableViewController(from navigation: UINavigationController?, tripID: String, cityId: String) {
        let vC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlaceTableVC") as! PlaceTableVC
        vC.viewModel.tripID = tripID
        vC.viewModel.cityId = cityId
        vC.viewModel.uiDependOn = "Edit"
        navigation?.pushViewController(vC, animated: true)
    }
}
