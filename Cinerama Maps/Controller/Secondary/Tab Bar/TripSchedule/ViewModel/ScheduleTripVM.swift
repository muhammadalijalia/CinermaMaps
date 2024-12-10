//
//  ScheduleTripViewModel.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 21/10/24.
//

import Foundation
import DropDown

class ScheduleTripViewModel {
    
    var fethcedSuccessfully:(() -> Void)?
    var arrayOfScheduleTrip: [Res_ScheduleTrip] = []

    func fetchScheduleTrip(vC: UIViewController)
    {
        Api.shared.requestScheduleTrip(vC) { responseData in
            if responseData.count > 0 {
                self.arrayOfScheduleTrip = responseData
            } else {
                self.arrayOfScheduleTrip = []
            }
            self.fethcedSuccessfully?()
        }
    }
    
    func deleteTripSchedule(vC: UIViewController, trip_iD: String)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["trip_id"] = trip_iD as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToDeleteTripSchedule(vC, paramDict) { responseData in
            if responseData.status == "1" {
                self.fethcedSuccessfully?()
            }
        }
     }
    
    func navigateToMoreAboutViewController(from navigationController: UINavigationController?, tableName: String, cityiD:String) {
        let vC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoreAboutTripVC") as! MoreAboutTripVC
        vC.viewModel.tableName = tableName
        vC.viewModel.cityiD = cityiD
        navigationController?.pushViewController(vC, animated: true)
    }
}
