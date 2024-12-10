//
//  PaymentVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 28/08/24.
//

import UIKit
import InputMask
import LanguageManager_iOS

class PaymentVC: UIViewController {

    @IBOutlet weak var lbl_Type:UILabel!
    @IBOutlet weak var lbl_TotalDuration:UILabel!
    @IBOutlet weak var lbl_totalAmount:UILabel!
    
    @IBOutlet weak var txtCardHolderName: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtExpiryDate: UITextField!
    @IBOutlet weak var txtSecurityCode: UITextField!
    @IBOutlet var listnerCardNum: MaskedTextFieldDelegate!
    @IBOutlet var listerExpiryDate: MaskedTextFieldDelegate!
    
    let viewModel: PaymentViewModel
    
    var typeVal: String = ""
    var duration: String = ""
    var totalPaidAmount: String = ""
    
    init(viewModel: PaymentViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        // Provide a default ViewModel to avoid crash
        self.viewModel = PaymentViewModel()  // Replace with proper default if needed
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.configureListener(listnerCardNum: listnerCardNum, listerExpiryDate: listerExpiryDate)
        bindViewModel()
        self.lbl_Type.text = typeVal
        self.lbl_TotalDuration.text = "\(self.duration) \("Month".localiz())"
        self.lbl_totalAmount.text = "SAR \(self.totalPaidAmount)"
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func bindViewModel()
    {
        viewModel.showErrorMessage = { [weak self] in
            if let errorMessage = self?.viewModel.errorMessage {
                Utility.showAlertMessage(withTitle: k.appName, message: errorMessage, delegate: nil, parentViewController: self!)
            }
        }
        
        viewModel.fetchedSuccessfully = { [self] in
            let vC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PresentPopUpVC") as! PresentPopUpVC
            vC.modalTransitionStyle = .crossDissolve
            vC.modalPresentationStyle = .overFullScreen
            self.present(vC, animated: true)
        }
    }
    
    @IBAction func btn_Pay(_ sender: UIButton) {
        viewModel.cardHolderName = self.txtCardHolderName.text ?? ""
        if let cardNumber = self.txtCardNumber.text {
            let sanitizedCardNumber = cardNumber.replacingOccurrences(of: " ", with: "")
            viewModel.cardHolderNumber = sanitizedCardNumber
        }
        viewModel.cvc = self.txtSecurityCode.text ?? ""
        let expiryDate = self.txtExpiryDate.text ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/yy" // Specify the format of the input string

        if let date = dateFormatter.date(from: expiryDate) {
            // Use Calendar to extract month and year
            let calendar = Calendar.current
            let month = calendar.component(.month, from: date)
            let year = calendar.component(.year, from: date)
            
            print("Month: \(month), Year: \(year)") // Output: Month: 12, Year: 2038
            viewModel.month = String(month)
            viewModel.year = String(year)
        }
        viewModel.total_Amount = totalPaidAmount
        viewModel.callAddPaymentRequest(vC: self)
    }
}
