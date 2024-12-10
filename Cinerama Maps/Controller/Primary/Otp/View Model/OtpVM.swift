//
//  OtpViewModel.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 31/08/24.
//

import Foundation
import OTPFieldView
import LanguageManager_iOS

class OtpViewModel {
    
    var signupStatus: String = ""
    var res_SendOtpModel: Api_SendOtp!
    var mobileNum: String = ""
    
    var verificationCode: String = ""
    var enteredOtp:String!
    var otpNumber: String = ""
    
    var errorMessage: String = ""
    
    var cloResendOtp:((_ vC: UIViewController) -> Void)?

    func setupOtpView(for otpTextFieldView: OTPFieldView!) {
        otpTextFieldView.fieldsCount = 4
        otpTextFieldView.fieldBorderWidth = 1
        otpTextFieldView.defaultBorderColor = #colorLiteral(red: 0.8862745098, green: 0.368627451, blue: 0.07843137255, alpha: 1)
        otpTextFieldView.filledBorderColor = #colorLiteral(red: 0.8862745098, green: 0.368627451, blue: 0.07843137255, alpha: 1)
        otpTextFieldView.cursorColor = #colorLiteral(red: 0.8862745098, green: 0.368627451, blue: 0.07843137255, alpha: 1)
        otpTextFieldView.displayType = .roundedCorner
        otpTextFieldView.fieldSize = 40
        otpTextFieldView.separatorSpace = 8
        otpTextFieldView.shouldAllowIntermediateEditing = false
        otpTextFieldView.initializeUI()
        otpTextFieldView.delegate = self
    }
    
    func navigateToSignupViewController(from navigationController: UINavigationController?) {
        let vC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        vC.signupViewModel.isComingFrom = "Otp"
        vC.signupViewModel.uMobile = mobileNum
        navigationController?.pushViewController(vC, animated: true)
    }
    
    func returnBackk(from navigationController: UINavigationController?) {
        navigationController?.popViewController(animated: true)
    }
}

extension OtpViewModel: OTPFieldViewDelegate {
    
    func manageUserSession()
    {
        k.userDefault.set(true, forKey: k.session.status)
        k.userDefault.set(res_SendOtpModel.user_details?.id, forKey: k.session.userId)
        k.userDefault.set(res_SendOtpModel.user_details?.email ?? "", forKey: k.session.userEmail)
        Switcher.updateRootVC()
    }
    
    func validateInput() -> Bool {
        if verificationCode != enteredOtp {
            errorMessage = "Please enter the valid verification code".localiz()
            return false
        }
        return true
    }
    
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        return false
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        self.enteredOtp = otpString
    }
}

