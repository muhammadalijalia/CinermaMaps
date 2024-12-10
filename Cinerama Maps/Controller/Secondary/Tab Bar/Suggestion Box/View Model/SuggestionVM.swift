//
//  SuggestionViewModel.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 04/11/24.
//

import Foundation
import LanguageManager_iOS

class SuggestionViewModel {

    var fetchedSuccessful:(() -> Void)?
    
    var countryName:String = ""
    var countryDescription:String = ""
    
    var errorMessage: String? {
        didSet {
            self.showErrorMessage?()
        }
    }
    
    var showErrorMessage: (() -> Void)?
    
    func addSuggestion(vC: UIViewController)
    {
        guard self.isValidUserInput() else { return }
        
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["country_name"] = countryName as AnyObject
        paramDict["description"] = countryDescription as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToSuggest(vC, paramDict) { responseData in
            self.fetchedSuccessful?()
        }
    }
    
    func isValidUserInput() -> Bool
    {
        if countryName.isEmpty {
            errorMessage = "Please enter the country name".localiz()
            return false
        } else if countryDescription.isEmpty {
            errorMessage = "Please enter the description".localiz()
            return false
        }
        return true
    }
}
