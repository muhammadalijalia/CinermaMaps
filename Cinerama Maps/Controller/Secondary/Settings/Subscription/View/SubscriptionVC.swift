//
//  SubscriptionVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 23/08/24.
//

import UIKit
import LanguageManager_iOS

class SubscriptionVC: UIViewController {
    
    @IBOutlet weak var subscription_TableVw: UITableView!
    @IBOutlet weak var subscription_TableHeight: NSLayoutConstraint!
    
    var viewModel: PurchasedCityViewModel
    
    init(viewModel: PurchasedCityViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = PurchasedCityViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subscription_TableVw.register(UINib(nibName: "SubscriptionCell", bundle: nil), forCellReuseIdentifier: "SubscriptionCell")
        setUpBinding()
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpBinding()
    {
        viewModel.fetchPurchaseCityMap(vC: self, tableHeight: subscription_TableHeight)
        viewModel.requestSuccessfull = {[] in
            self.subscription_TableVw.reloadData()
        }
    }
}

extension SubscriptionVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrayOfPurchasedCityMap.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubscriptionCell", for: indexPath) as! SubscriptionCell
        
        let obj = self.viewModel.arrayOfPurchasedCityMap[indexPath.row]
        cell.lbl_MapName.text = obj.name
        cell.lbl_Amount.text = "\(obj.city_map_price ?? "") SAR for \(obj.city_map_month ?? "") Month"
        cell.lbl_AboutCity.text = obj.about_city ?? ""
        
        cell.cloCancelPackage = { [] in
            Utility.showAlertYesNoAction(withTitle: k.appName, message: "Do you want to cancel this subscription".localiz(), delegate: nil, parentViewController: self) { [self] bool in
                if bool {
                    self.viewModel.cancelSubcription(vC: self, countryId: obj.country_id ?? "", cityId: obj.id ?? "")
                    self.viewModel.requestSuccessfull = { [] in
                        self.setUpBinding()
                    }
                } else {
                    self.dismiss(animated: true)
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

