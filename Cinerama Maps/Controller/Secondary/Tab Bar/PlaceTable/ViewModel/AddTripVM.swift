//
//  AddUpdateTrip.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 05/11/24.
//

import Foundation

class AddTripViewModel {
    
    var addedSuccessfully:(() -> Void)?
    
    var place_iD:String = ""
    var mapType:String = ""
    var map_TypeAr:String = ""
    
    var trip_PlaceiD:String = ""
    var map_PlaceiD:String = ""
    
    //    var mapName:String = ""
    var table_map_name:String = ""
    
    var location:String = ""
    var valLat:Double = 0.0
    var valLon:Double = 0.0
    //    var tripDays: String = ""
    var isCNRM: String = ""
    
    var trip_iD:String = ""
    var trip_Name:String = ""
    var trip_NameAr:String = ""
    
    var country_Id:String = ""
    var country_Name:String = ""
    var country_NameAr:String = ""
    
    var day_Id:String = ""
    var day_Name:String = ""
    var day_NameAr:String = ""
    
    var errorMessage: String? {
        didSet {
            self.showErrorMessage?()
        }
    }
    
    var showErrorMessage: (() -> Void)?
    
//    func isValidUserInput() -> Bool
//    {
//        if mapType.isEmpty {
//            errorMessage = "Please select the map type"
//            return false
//        } else if table_map_name.isEmpty {
//            errorMessage = "Please enter the map name"
//            return false
//        } else if day_Name.isEmpty {
//            errorMessage = "Please enter the trip days"
//            return false
//        }
//        return true
//    }
    
    func addNewTrip(vC: UIViewController)
    {
//        guard isValidUserInput() else { return }
        
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["place_id"] = place_iD as AnyObject
        
        paramDict["map_name"] = k.emptyString as AnyObject
        paramDict["table_map_name"] = table_map_name as AnyObject
        
        paramDict["trip_id"] = trip_iD as AnyObject
        paramDict["trip_name"] = trip_Name as AnyObject
        paramDict["trip_name_ar"] = trip_NameAr as AnyObject
        
        paramDict["country_id"] = country_Id as AnyObject
        paramDict["country_name"] = country_Name as AnyObject
        paramDict["country_name_ar"] = country_NameAr as AnyObject
        
        paramDict["trip_place_id"] = trip_PlaceiD as AnyObject
        paramDict["map_place_id"] = map_PlaceiD as AnyObject
        
        paramDict["map_type"] = mapType as AnyObject
        paramDict["map_type_ar"] = map_TypeAr as AnyObject
        
        paramDict["day_id"] = day_Id as AnyObject
        paramDict["day_name"] = day_Name as AnyObject
        paramDict["day_name_ar"] = day_NameAr as AnyObject
        
        paramDict["address"] = location as AnyObject
        paramDict["how_much_day"] = k.emptyString as AnyObject
        paramDict["trip_by_cineramap"] = isCNRM as AnyObject
        
        paramDict["lat"] = valLat as AnyObject
        paramDict["lon"] = valLon as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToUpdateScheduleTrip(vC, paramDict) { [self] responseData in
            self.addedSuccessfully?()
        }
    }
}
