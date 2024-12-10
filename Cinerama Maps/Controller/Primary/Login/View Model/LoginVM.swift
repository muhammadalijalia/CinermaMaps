//
//  LoginViewModel.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 31/08/24.
//

import Foundation
import CountryPickerView
import DropDown
import LanguageManager_iOS

class LoginViewModel {
    
    var mobileNum: String = ""
    var signupStatus: String = ""
    var verificationCode: String = ""
    
    var api_ModelToRescueResponse: Api_SendOtp!
    
    var errorMessage: String? {
        didSet {
            self.showErrorMessage?()
        }
    }
    
    var dropDown = DropDown()
    var selectedVal: String = ""
    
    var showErrorMessage: (() -> Void)?
    var loginSuccess: (() -> Void)?
    
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
    
    func navigateToOtpViewController(from navigationController: UINavigationController?) {
        let vC = Kstoryboard.instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
        vC.viewModel.signupStatus = signupStatus
        vC.viewModel.res_SendOtpModel = api_ModelToRescueResponse
        vC.viewModel.verificationCode = verificationCode
        vC.viewModel.cloResendOtp = { (viewController) in
            self.requestToCallVerifyNum(vC: viewController, shouldNavigate: false)
        }
        vC.viewModel.mobileNum = self.mobileNum
        navigationController?.pushViewController(vC, animated: true)
    }
    
    func configureDropDown(sender: UIButton)
    {
        dropDown.anchorView = sender
        dropDown.show()
        switch LanguageManager.shared.currentLanguage {
        case .en:
            dropDown.dataSource = ["English","Arabic"]
            dropDown.bottomOffset = CGPoint(x: -60, y: 40)
        default:
            dropDown.dataSource = ["الإنجليزية","العربية"]
            dropDown.bottomOffset = CGPoint(x: 280, y: 40)
        }
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
           selectedVal = item
            if index == 0 {
                k.userDefault.set(emLang.english.rawValue, forKey: k.session.language)
                LanguageManager.shared.setLanguage(language: .en)
                Switcher.updateRootVC()
            } else  {
                k.userDefault.set(emLang.arabic.rawValue, forKey: k.session.language)
                LanguageManager.shared.setLanguage(language: .ar)
                Switcher.updateRootVC()
            }
        }
    }
}

extension LoginViewModel {
    
    // Validate user input
    func validateInput() -> Bool {
        if mobileNum.isEmpty {
            errorMessage = "Please enter the valid mobile number".localiz()
            return false
        }
        return true
    }
    
    func requestToCallVerifyNum(vC: UIViewController, shouldNavigate: Bool = true) {
        
        guard self.validateInput() else { return }
        
        var param: [String : AnyObject] = [:]
        param["mobile"] = mobileNum as AnyObject
        param["mobile_with_code"] = "\(phoneKey!)\(mobileNum)" as AnyObject
        
        print(param)
        
        Api.shared.requestOtpToVerifyNum(vC, param) { responseData in
            // Assuming `responseData` is a dictionary that contains a `status` key
            if let status = responseData.status, status == "1" {
                self.api_ModelToRescueResponse = responseData
                self.signupStatus = responseData.signup_statu ?? ""
                if let result = responseData.result {
                    print(result.code ?? 0)
                    self.verificationCode = String(result.code ?? 0)
                }
                if shouldNavigate  {
                    self.loginSuccess?()
                } else {
                    print("Call Api without navigating!!")
                }
            } else {
                print(vC.alert(alertmessage: responseData.message ?? ""))
            }
        }
    }
}

extension LoginViewModel: CountryPickerViewDelegate, CountryPickerViewDataSource {
    
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

