//
//  SuggestionVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 04/11/24.
//

import UIKit
import LanguageManager_iOS

class SuggestionVC: UIViewController {
    
    @IBOutlet weak var txt_EnterName: UITextField!
    @IBOutlet weak var txt_Description: UITextView!
    
    let viewModel = SuggestionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Submit(_ sender: UIButton) {
        viewModel.countryName = self.txt_EnterName.text ?? ""
        viewModel.countryDescription = self.txt_Description.text ?? ""
        viewModel.addSuggestion(vC: self)
    }
    
    private func bindViewModel()
    {
        viewModel.showErrorMessage = { [weak self] in
            if let errorMessage = self?.viewModel.errorMessage {
                Utility.showAlertMessage(withTitle: k.appName, message: errorMessage, delegate: nil, parentViewController: self!)
            }
        }
        
        viewModel.fetchedSuccessful = { [] in
            Utility.showAlertWithAction(withTitle: k.appName, message: "Suggesstion added successfully".localiz(), delegate: nil, parentViewController: self) { bool in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
