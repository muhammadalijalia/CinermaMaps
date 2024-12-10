//
//  SettingVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 23/08/24.
//

import UIKit

class SettingVC: UIViewController {

    @IBOutlet weak var profile_Img: UIImageView!
    @IBOutlet weak var lbl_UserName: UILabel!
    
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProfileDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func fetchProfileDetail()
    {
        viewModel.fetchUserProfileDetails(vC: self)
        viewModel.fetchSuccessfully = { [] in
            DispatchQueue.main.async { [self] in
                let obj = self.viewModel.arrayUserProfile
                self.lbl_UserName.text = "\(obj?.first_name ?? "") \(obj?.last_name ?? "")"
                
                if Router.BASE_IMAGE_URL != obj?.image {
                    Utility.setImageWithSDWebImage(obj?.image ?? "", self.profile_Img)
                } else {
                    self.profile_Img.image = R.image.profile_ic()
                }
            }
        }
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_EditProfile(_ sender: UIButton) {
        let vC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_TermsCondition(_ sender: UIButton) {
        let vC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Policy_sVC") as! Policy_sVC
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_Subscription(_ sender: UIButton) {
        let vC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubscriptionVC") as! SubscriptionVC
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_ChangeLanguage(_ sender: UIButton) {
        let vC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LanguageVC") as! LanguageVC
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_Application(_ sender: UIButton) {

    }
    
    @IBAction func btn_ContactUs(_ sender: UIButton) {
        let vC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_DeleteAccnt(_ sender: UIButton) {
       
    }
    
    @IBAction func btn_Logout(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: k.session.status)
        UserDefaults.standard.synchronize()
        Switcher.updateRootVC()
    }
}
