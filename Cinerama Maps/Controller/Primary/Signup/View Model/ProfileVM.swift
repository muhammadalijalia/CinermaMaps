//
//  ProfileViewModel.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 03/09/24.
//

import Foundation
import DropDown
import CountryPickerView

class ProfileViewModel {
    
    var isComingFrom: String = ""
    var navigationTitle = ""
    
    var uFirstName: String = ""
    var uLastName: String = ""
    var uMobile: String = ""
    var uEmail: String = ""
    var uGender: String = ""
    var uDob: String = "2024-01-02"
    var profileImage: String = ""
    
    var fetchedSuccess: (() -> Void)?
    
    func textOnValue() -> String {
        if isComingFrom == "Otp" {
            return "Register Your Profile"
        } else {
            return "Edit Profile"
        }
    }
    
    func requestUserProfile(vC: UIViewController)
    {
        Api.shared.requestUserProfile(vC) { responseData in
            print(responseData)
            let obj = responseData
            self.uFirstName = obj.first_name ?? ""
            self.uLastName = obj.last_name ?? ""
            self.uMobile = obj.mobile ?? ""
            self.uEmail = obj.email ?? ""
            self.uGender = obj.gender ?? ""
            self.uDob = obj.dob ?? ""
            self.profileImage = obj.image ?? ""
            self.fetchedSuccess?()
        }
    }
}
