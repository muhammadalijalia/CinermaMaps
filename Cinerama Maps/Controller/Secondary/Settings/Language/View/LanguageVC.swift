//
//  LanguageVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 27/11/24.
//

import UIKit
import LanguageManager_iOS

class LanguageVC: UIViewController {
    
    @IBOutlet weak var eng_Img: UIImageView!
    @IBOutlet weak var arb_Img: UIImageView!
    
    var selected_Language:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if LanguageManager.shared.currentLanguage == .en {
            self.eng_Img.image = R.image.ic_CheckedCircle_Black()
        } else {
            self.arb_Img.image = R.image.ic_CheckedCircle_Black()
        }
    }
    
    @IBAction func btn_back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_English(_ sender: UIButton) {
        self.eng_Img.image = R.image.ic_CheckedCircle_Black()
        self.arb_Img.image = R.image.ic_Circle_Black()
        self.selected_Language = "en"
    }
    
    @IBAction func btn_Arabic(_ sender: UIButton) {
        self.eng_Img.image = R.image.ic_Circle_Black()
        self.arb_Img.image = R.image.ic_CheckedCircle_Black()
        self.selected_Language = "ar"
    }
    
    @IBAction func btn_Save(_ sender: UIButton) {
        switch selected_Language {
        case "en":
            k.userDefault.set(emLang.english.rawValue, forKey: k.session.language)
            LanguageManager.shared.setLanguage(language: .en)
            Switcher.updateRootVC()
        default:
            k.userDefault.set(emLang.arabic.rawValue, forKey: k.session.language)
            LanguageManager.shared.setLanguage(language: .ar)
            Switcher.updateRootVC()
        }
    }
}
