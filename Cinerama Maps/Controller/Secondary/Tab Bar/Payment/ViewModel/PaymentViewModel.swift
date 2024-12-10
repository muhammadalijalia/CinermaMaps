//
//  PaymentViewModel.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 15/11/24.
//

import Foundation
import InputMask
import SwiftyJSON
import LanguageManager_iOS

class PaymentViewModel {
    
    var cardHolderName:String = ""
    var cardHolderNumber:String = ""
    var cvc:String = ""
    var month:String = ""
    var year:String = ""
    var total_Amount:String = ""
    
    var countryMapiD:String = ""
    var countryCityiD:String = ""
    
    var errorMessage: String? {
        didSet {
            self.showErrorMessage?()
        }
    }
    
    var showErrorMessage: (() -> Void)?
    var fetchedSuccessfully:(() -> Void)?
    
    func isValidUserInput() -> Bool
    {
        if cardHolderName.isEmpty {
            errorMessage = "Please enter the name".localiz()
            return false
        } else if cardHolderNumber.isEmpty {
            errorMessage = "Please enter the card number".localiz()
            return false
        } else if cvc.isEmpty {
            errorMessage = "Please enter the cvc number".localiz()
            return false
        } else if month.isEmpty && year.isEmpty {
            errorMessage = "Please enter the month and year".localiz()
            return false
        }
        return true
    }
    
    func configureListener(listnerCardNum: MaskedTextFieldDelegate, listerExpiryDate: MaskedTextFieldDelegate)
    {
        listnerCardNum.affinityCalculationStrategy = .prefix
        listnerCardNum.affineFormats = ["[0000] [0000] [0000] [0000]"]
        
        listerExpiryDate.affinityCalculationStrategy = .prefix
        listerExpiryDate.affineFormats = ["[00]/[00]"]
    }
    
    func callAddPaymentRequest(vC: UIViewController)
    {
        guard isValidUserInput() else { return }
        
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["payment_method"] = "Card" as AnyObject
        paramDict["currency"] = "SAR" as AnyObject
        paramDict["transaction_type"] = "Top Up" as AnyObject
        paramDict["type"] = "creditcard" as AnyObject
        paramDict["name"] = cardHolderName as AnyObject
        paramDict["number"] = cardHolderNumber as AnyObject
        paramDict["cvc"] = cvc as AnyObject
        paramDict["month"] = month as AnyObject
        paramDict["year"] = year as AnyObject
        paramDict["total_amount"] = total_Amount as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToAddPayment(vC, paramDict) { [self] responseData in
            self.parseDataSaveCard(apiResponse: responseData, vC: vC)
        }
    }
    
    func parseDataSaveCard(apiResponse : AnyObject, vC: UIViewController) {
        DispatchQueue.main.async { [self] in
            let swiftyJsonVar = JSON(apiResponse)
            print(swiftyJsonVar)
            if(swiftyJsonVar["status"] == "1") {
                print(swiftyJsonVar["result"]["id"].stringValue)
                self.requestForFinalPayment(vC: vC, planiD: swiftyJsonVar["result"]["id"].stringValue)
            } else {
                print("Something Went Wrong")
            }
            vC.unBlockUi()
        }
    }
    
    func requestForFinalPayment(vC: UIViewController, planiD: String)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["plan_id"] = planiD as AnyObject
        paramDict["amount"] = total_Amount as AnyObject
        paramDict["map_country_id"] = countryMapiD as AnyObject
        paramDict["map_city_id"] = countryCityiD as AnyObject
        paramDict["transaction_id"] = total_Amount as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToPurchasePlan(vC, paramDict) { responseData in
            self.fetchedSuccessfully?()
        }
    }
}
