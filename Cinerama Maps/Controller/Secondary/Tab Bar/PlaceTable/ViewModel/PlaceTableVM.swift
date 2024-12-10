//
//  SetupTripViewModel.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 22/10/24.
//

import Foundation
import DropDown

class PlaceTableViewModel {
    
    var fetchedSuccessfully:(() -> Void)?
    var arrayOfDetailTrip: Res_DetailScheduleTrip!
    
    // For DropDown
    var fetchedDayNameSuccessfully:(() -> Void)?
    var arrayOfScheduleTripMapName: [Res_ScheduleTripMapName] = []
    var arrayScheduleDayName: [Res_DaysSelection] = []
    
    var mapType:String = ""
    
    var dayiD:String = ""
    var dayName:String = ""
    var dayNameAr:String = ""
    
    var tripID:String = ""
    var cityId:String = ""
    
    var dropDownMapName = DropDown()
    var dropDownDays = DropDown()
    
    var uiDependOn:String = ""
    
    func fetchDetailScheduleTrip(vC: UIViewController)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["trip_id"] = tripID as AnyObject
        
        print(paramDict)
        
        Api.shared.requestDetailsScheduleTrip(vC, paramDict) { responseData in
            self.arrayOfDetailTrip = responseData
            self.fetchedSuccessfully?()
        }
    }
    
    func configureDropDownForMapName(sender: UIButton)
    {
        var arrayOfMapName: [String] = []
        var arrayofMapId: [String] = []
        
        for val in arrayOfScheduleTripMapName {
            arrayOfMapName.append(val.map_name ?? "")
            arrayofMapId.append(val.id ?? "")
        }
        
        dropDownMapName.anchorView = sender
        dropDownMapName.dataSource = arrayOfMapName
        dropDownMapName.backgroundColor = .white
        dropDownMapName.setupCornerRadius(8)
        dropDownMapName.separatorColor = .systemBackground
        dropDownMapName.bottomOffset = CGPoint(x: -5, y: 45)
        dropDownMapName.selectionAction = { [unowned self] (index: Int, item: String) in
            sender.setTitle(item, for: .normal)
            mapType = item
        }
    }
    
    func fetchScheduleTripMapName(vC: UIViewController)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["country_id"] = k.emptyString as AnyObject
        paramDict["city_id"] = cityId as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToScheduleTripMapName(vC, paramDict) { responseData in
            if responseData.count > 0 {
                self.arrayOfScheduleTripMapName = responseData
            } else {
                self.arrayOfScheduleTripMapName = []
            }
            self.fetchedSuccessfully?()
        }
    }
    
    func configureDropDownForDaySelection(sender: UIButton)
    {
        var arrayOfDayName: [String] = []
        var arrayOfDayNameAr: [String] = []
        var arrayOfDayId: [String] = []
        
        for val in arrayScheduleDayName {
            arrayOfDayName.append(val.day_name ?? "")
            arrayOfDayNameAr.append(val.day_name_ar ?? "")
            arrayOfDayId.append(val.id ?? "")
        }
        
        dropDownDays.anchorView = sender
        dropDownDays.dataSource = arrayOfDayName
        dropDownDays.backgroundColor = .white
        dropDownDays.setupCornerRadius(8)
        dropDownDays.separatorColor = .systemBackground
        dropDownDays.bottomOffset = CGPoint(x: -5, y: 45)
        dropDownDays.selectionAction = { [unowned self] (index: Int, item: String) in
            sender.setTitle(item, for: .normal)
            dayiD = arrayOfDayId[index]
            dayName = item
            dayNameAr = arrayOfDayNameAr[index]
        }
    }
    
    func fetchNumberOfDays(vC: UIViewController)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        
        Api.shared.requestToDaySelection(vC, paramDict) { responseData in
            if responseData.count > 0 {
                self.arrayScheduleDayName = responseData
            } else {
                self.arrayScheduleDayName = []
            }
            self.fetchedDayNameSuccessfully?()
        }
    }
}
