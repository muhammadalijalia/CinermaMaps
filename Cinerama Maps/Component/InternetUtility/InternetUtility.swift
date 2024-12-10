//
//  InternetUtility.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 02/09/24.
//

import Foundation
import UIKit
import LanguageManager_iOS

let NETWORK_ERROR_MSG : String  = "No internet connection make sure your device is connected to the internet".localiz()

class InternetUtilClass {
    
    class var sharedInstance: InternetUtilClass {
        
        struct Static {
            static let instance: InternetUtilClass = InternetUtilClass()
            static var reachability: Reachability? = Reachability.forInternetConnection()
        }
        
        return Static.instance
    }
    
    func hasConnectivity() -> Bool {
        let reachability: Reachability = Reachability.forInternetConnection()
        let networkStatus: Int = reachability.currentReachabilityStatus().rawValue
        return networkStatus != 0
    }
}

