//
//  RatingVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 05/11/24.
//

import UIKit
import Cosmos
import LanguageManager_iOS

class RatingVC: UIViewController {

    @IBOutlet weak var cosmosRating: CosmosView!
    @IBOutlet weak var txt_Review: UITextView!
    
    let viewModel = ServiceRatingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }

    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Done(_ sender: UIButton) {
        viewModel.ratingStar = cosmosRating.rating
        viewModel.ratingMessage = txt_Review.text
        viewModel.addServiceRating(vC: self)
    }
    
    private func bindViewModel()
    {
        viewModel.showErrorMessage = { [weak self] in
            if let errorMessage = self?.viewModel.errorMessage {
                Utility.showAlertMessage(withTitle: k.appName, message: errorMessage, delegate: nil, parentViewController: self!)
            }
        }
        
        viewModel.fetchedSuccessfully = { [] in
            Utility.showAlertWithAction(withTitle: k.appName, message: "Rating added successfully".localiz(), delegate: nil, parentViewController: self) { bool in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

}
