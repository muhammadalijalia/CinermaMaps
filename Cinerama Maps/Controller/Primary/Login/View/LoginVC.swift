//
//  LoginVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 22/08/24.
//

import UIKit
import CountryPickerView
import LanguageManager_iOS

class LoginVC: UIViewController {
    
    @IBOutlet weak var txt_CountryPicker: UITextField!
    @IBOutlet weak var txt_MobileNum: UITextField!
    @IBOutlet weak var lbl_Language: UILabel!
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.configureCountryPicker(for: txt_CountryPicker)
        setupBindings()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
//        if LanguageManager.shared.currentLanguage == .en {
//            self.lbl_Language.text = "English"
//        } else {
//            self.lbl_Language.text = "الإنجليزية"
//        }
    }
    
    @IBAction func btn_Login(_ sender: UIButton) {
        viewModel.mobileNum = txt_MobileNum.text ?? ""
        viewModel.requestToCallVerifyNum(vC: self)
    }
    
    private func setupBindings() {
        viewModel.showErrorMessage = { [weak self] in
            if let errorMessage = self?.viewModel.errorMessage {
                Utility.showAlertMessage(withTitle: k.appName, message: errorMessage, delegate: nil, parentViewController: self!)
            }
        }
        
        viewModel.loginSuccess = { [] in
            self.viewModel.navigateToOtpViewController(from: self.navigationController)
        }
    }
    
    @IBAction func btn_DropLanguage(_ sender: UIButton)
    {
        viewModel.configureDropDown(sender: sender)
        self.lbl_Language.text = viewModel.selectedVal
    }
}

