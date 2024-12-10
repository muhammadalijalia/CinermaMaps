//
//  ServiceRatingViewModel.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 05/11/24.
//

import Foundation
import LanguageManager_iOS

class ServiceRatingViewModel {
    
    var fetchedSuccessfully:(() -> Void)?
    
    var ratingStar: Double = 0.0
    var ratingMessage: String = ""
    var serviceId: String = ""
    
    var errorMessage: String? {
        didSet {
            self.showErrorMessage?()
        }
    }
    
    var showErrorMessage: (() -> Void)?
    
    func isValidUserInput() -> Bool
    {
        if ratingStar.isZero {
            errorMessage = "Please select the rating star".localiz()
            return false
        } else if ratingMessage.isEmpty {
            errorMessage = "Please give the review".localiz()
            return false
        }
        return true
    }
    
    func addServiceRating(vC: UIViewController) {
        
        guard isValidUserInput() else { return }
        
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["service_id"] = serviceId as AnyObject
        paramDict["rating"] = ratingStar as AnyObject
        paramDict["review"] = ratingMessage as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToAddServiceRating(vC, paramDict) { [self] responseData in
            self.fetchedSuccessfully?()
        }
    }
}
