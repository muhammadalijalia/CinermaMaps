//
//  SetUpTripScheduleVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 14/11/24.
//

import UIKit
import LanguageManager_iOS

class SetUpTripScheduleVC: UIViewController {

    @IBOutlet weak var txt_MapName: UITextField!
    @IBOutlet weak var btnDropOt: UIButton!
    
    let viewModel: SetupTripVM
    
    var byCNRM:String = ""
    
    init(viewModel: SetupTripVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        // Provide a default ViewModel to avoid crash
        self.viewModel = SetupTripVM()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBinding()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setAddTrip()
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_MapType(_ sender: UIButton) {
        viewModel.dropDown.show()
    }
    
    @IBAction func btn_ByCNRM(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            sender.setImage(R.image.rectangleUncheck(), for: .normal)
            byCNRM = "No"
        } else {
            sender.isSelected = true
            sender.setImage(R.image.rectangleChecked(), for: .normal)
            byCNRM = "Yes"
        }
    }
    
    private func setupBinding()
    {
        viewModel.fetchPurchaseCityMap(vC: self)
        viewModel.fethcedSuccessfully = { [] in
            print("Data Fetched Successfully!")
            self.viewModel.configureDropDown(sender: self.btnDropOt)
        }
    }
    
    @IBAction func btn_Create(_ sender: UIButton) {
        viewModel.mapName = self.txt_MapName.text ?? ""
        viewModel.addNewTrip(vC: self)
    }
    
    private func setAddTrip()
    {
        viewModel.showErrorMessage = { [weak self] in
            if let errorMessage = self?.viewModel.errorMessage {
                Utility.showAlertMessage(withTitle: k.appName, message: errorMessage, delegate: nil, parentViewController: self!)
            }
        }
        
        viewModel.fethcedSuccessfully = { [] in
            Utility.showAlertWithAction(withTitle: k.appName, message: "Trip added successfully".localiz(), delegate: nil, parentViewController: self) { bool in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
