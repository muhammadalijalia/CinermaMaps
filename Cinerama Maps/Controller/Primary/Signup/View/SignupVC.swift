//
//  EditProfileVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 24/08/24.
//

import UIKit

class SignupVC: UIViewController {

    @IBOutlet weak var lbl_NavigationTitle: UILabel!
    @IBOutlet weak var lbl_FullName: UILabel!
    @IBOutlet weak var txt_FirstName: UITextField!
    @IBOutlet weak var txt_LastName: UITextField!
    @IBOutlet weak var txt_MobileNum: UITextField!
    @IBOutlet weak var txt_CountryPicker: UITextField!
    @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var btn_SelectGenderOt: UIButton!
    @IBOutlet weak var btn_DOBOt: UIButton!
    @IBOutlet weak var btn_ImagePickerOt: UIButton!
    
    let signupViewModel = SignupViewModel()
    let profileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbl_NavigationTitle.text = signupViewModel.textOnValue()
        self.txt_MobileNum.text = signupViewModel.uMobile
        signupViewModel.configureCountryPicker(for: txt_CountryPicker)
        fetchUserDetails()
        setupBindings()
    }

    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_SetProfileImg(_ sender: UIButton) {
        signupViewModel.configureProfileImg(vC: self, sender: sender)
    }
    
    @IBAction func btn_SelectGender(_ sender: UIButton) {
        signupViewModel.configureDropDown(sender: sender)
    }
    
    @IBAction func btn_SelectDOB(_ sender: UIButton) {
        self.datePickerTapped(strFormat: "yyyy/MM/dd", mode: .date) { dateString in
            print(dateString)
            self.signupViewModel.uDob = dateString
            sender.setTitle(dateString, for: .normal)
        }
    }
    
    @IBAction func btn_Save(_ sender: UIButton) {
        signupViewModel.uFirstName = txt_FirstName.text ?? ""
        signupViewModel.uLastName = txt_LastName.text ?? ""
        signupViewModel.uEmail = txt_Email.text ?? ""
        signupViewModel.requestToRegisterUser(vC: self)
    }
    
    private func setupBindings() {
        signupViewModel.showErrorMessage = { [weak self] in
            if let errorMessage = self?.signupViewModel.errorMessage {
                Utility.showAlertMessage(withTitle: k.appName, message: errorMessage, delegate: nil, parentViewController: self!)
            }
        }
        
        signupViewModel.registerSuccess = { [] in
            Switcher.updateRootVC()
        }
    }
    
    private func fetchUserDetails()
    {
        profileViewModel.requestUserProfile(vC: self)
        profileViewModel.fetchedSuccess = { [] in
            self.lbl_FullName.text = "\(self.profileViewModel.uFirstName) \(self.profileViewModel.uLastName )"
            self.txt_FirstName.text = self.profileViewModel.uFirstName
            self.txt_LastName.text = self.profileViewModel.uLastName
            self.txt_Email.text = self.profileViewModel.uEmail
            self.txt_MobileNum.text = self.profileViewModel.uMobile
            self.btn_SelectGenderOt.setTitle(self.profileViewModel.uGender, for: .normal)
            self.btn_DOBOt.setTitle(self.profileViewModel.uDob, for: .normal)
            
            if Router.BASE_IMAGE_URL != self.profileViewModel.profileImage {
                Utility.setImageWithSDWebImageOnButton(self.profileViewModel.profileImage, self.btn_ImagePickerOt)
            } else {
                self.btn_ImagePickerOt.setImage(R.image.profile_ic(), for: .normal)
            }
        }
    }
}
