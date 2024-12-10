//
//  SignupViewModel.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 02/09/24.
//

import Foundation
import CountryPickerView
import DropDown
import LanguageManager_iOS

class SignupViewModel {
    
    var isComingFrom: String = ""
    var navigationTitle = ""
    
    var uFirstName: String = ""
    var uLastName: String = ""
    var uMobile: String = ""
    var uEmail: String = ""
    var uGender: String = ""
    var uDob: String = "2024-01-02"
    
    var image = UIImage()
    
    var dropDown = DropDown()
    
    var errorMessage: String? {
        didSet {
            self.showErrorMessage?()
        }
    }
    
    var showErrorMessage: (() -> Void)?
    var registerSuccess: (() -> Void)?
    
    weak var cpvTextField: CountryPickerView!
    var phoneKey:String! = ""
    
    func configureCountryPicker(for txt_CountryPicker: UITextField)
    {
        let cp = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 80, height: 14))
        cp.flagImageView.isHidden = true
        txt_CountryPicker.rightView = cp
        txt_CountryPicker.rightViewMode = .always
        txt_CountryPicker.leftView = nil
        txt_CountryPicker.leftViewMode = .never
        cpvTextField = cp
        let countryCode = "US"
        cpvTextField.setCountryByCode(countryCode)
        cp.delegate = self
        [cp].forEach {
            $0?.dataSource = self
        }
        phoneKey = cp.selectedCountry.phoneCode
        cp.countryDetailsLabel.font = UIFont.systemFont(ofSize: 12)
        cp.font = UIFont.systemFont(ofSize: 12)
    }
    
    func textOnValue() -> String {
        if isComingFrom == "Otp" {
            return "Register Your Profile"
        } else {
            return "Edit Profile"
        }
    }
    
    func configureDropDown(sender: UIButton)
    {
        dropDown.anchorView = sender
        dropDown.show()
        dropDown.dataSource = ["Male", "Female"]
        dropDown.bottomOffset = CGPoint(x: -5, y: 40)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            sender.setTitle(item, for: .normal)
            self.uGender = item
        }
    }
    
    func configureProfileImg(vC: UIViewController, sender: UIButton)
    {
        CameraHandler.shared.showActionSheet(vc: vC)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.image = image
            sender.contentMode = .scaleToFill
            sender.setImage(image, for: .normal)
        }
    }
}

extension SignupViewModel {
    
    func isValidUserInput() -> Bool
    {
        if uFirstName.isEmpty {
            errorMessage = "Please enter the first name".localiz()
            return false
        } else if uLastName.isEmpty {
            errorMessage = "Please enter the last name".localiz()
            return false
        } else if uEmail.isEmpty {
            errorMessage = "Please enter the email".localiz()
            return false
        } else if uMobile.isEmpty {
            errorMessage = "Please enter the mobile number".localiz()
            return false
        } else if uGender.isEmpty {
            errorMessage = "Please select your gender".localiz()
            return false
        } else if uDob.isEmpty {
            errorMessage = "Please enter your Date Of Birth".localiz()
            return false
        }
        
        return true
    }
    
    func requestToRegisterUser(vC: UIViewController)
    {
        guard self.isValidUserInput() else { return }
        
        var param: [String : String] = [:]
        param["first_name"] = uFirstName
        param["last_name"] = uLastName
        param["mobile"] = uMobile
        param["mobile_with_code"] = "\(phoneKey!)\(uMobile)"
        param["email"] = uEmail
        param["register_id"] = k.emptyString
        param["ios_register_id"] = k.iosRegisterId
        param["address"] = k.emptyString
        param["lat"] = k.emptyString
        param["lon"] = k.emptyString
        param["gender"] = uGender
        param["dob"] = uDob
        
        print(param)
        
        var paramImg: [String : UIImage] = [:]
        paramImg["image"] = self.image
        
        print(paramImg)
        
        Api.shared.signup(vC, param, images: paramImg, videos: [:]) { responseData in
            k.userDefault.set(true, forKey: k.session.status)
            k.userDefault.set(responseData.id ?? "", forKey: k.session.userId)
            k.userDefault.set(responseData.email ?? "", forKey: k.session.userEmail)
            k.userDefault.set(responseData.type ?? "", forKey: k.session.type)
            self.registerSuccess?()
        }
    }
}

extension SignupViewModel: CountryPickerViewDelegate, CountryPickerViewDataSource {
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.phoneKey = country.phoneCode
    }
    
    func preferredCountries(in countryPickerView: CountryPickerView) -> [Country] {
        var countries = [Country]()
        ["GB"].forEach { code in
            if let country = countryPickerView.getCountryByCode(code) {
                countries.append(country)
            }
        }
        return countries
    }
    
    func sectionTitleForPreferredCountries(in countryPickerView: CountryPickerView) -> String? {
        return "Preferred title"
    }
    
    func showOnlyPreferredSection(in countryPickerView: CountryPickerView) -> Bool {
        return false
    }
    
    func navigationTitle(in countryPickerView: CountryPickerView) -> String? {
        return "Select a Country"
    }
}

