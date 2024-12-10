//
//  PresentPopUpVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 28/08/24.
//

import UIKit

class PresentPopUpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btn_Cancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btn_GoToBack(_ sender: UIButton) {
        Switcher.updateRootVC()
    }
}
