//
//  MoreAboutTripVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 14/11/24.
//

import UIKit
import LanguageManager_iOS

class MoreAboutTripVC: UIViewController {

    @IBOutlet weak var table_Vw: UITableView!
    
    let viewModel: MoreAboutTripVM
    
    init(viewModel: MoreAboutTripVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        // Provide a default ViewModel to avoid crash
        self.viewModel = MoreAboutTripVM()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table_Vw.register(UINib(nibName: "MoreAboutTripCell", bundle: nil), forCellReuseIdentifier: "MoreAboutTripCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBinding()
    }

    @IBAction func btn_Back(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupBinding()
    {
        viewModel.fetchMoreAboutTrip(vC: self)
        viewModel.fetchSuccessfully = { [] in
            self.table_Vw.reloadData()
        }
    }
}

extension MoreAboutTripVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.arrayOfMoreTrip.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreAboutTripCell", for: indexPath) as! MoreAboutTripCell
        
        let obj = self.viewModel.arrayOfMoreTrip[indexPath.row]
        
        if let objDayWise = obj.day_wise_trip {
            for val in objDayWise {
                cell.lbl_Address.text = val.address ?? ""
                cell.lbl_KM.text = "\(val.distance ?? "") \("KM away from you".localiz())"
                cell.lbl_Minutes.text = "\(val.time ?? "")"
                cell.lbl_CityName.text = val.trip_name ?? ""
                cell.lbl_DayName.text = val.day_name ?? ""
                
                if val.trip_by_cineramap == "Yes" {
                    cell.lbl_CretedByCNRM.isHidden = false
                } else {
                    cell.lbl_CretedByCNRM.isHidden = true
                }
                
                cell.cloEdit = { [self] in
                    self.viewModel.navigateToPlaceTableViewController(from: self.navigationController, tripID: val.id ?? "", cityId: val.place_id ?? "")
                }
                
                cell.cloDelete = { [] in
                    self.viewModel.deleteTripSchedule(vC: self, cityiD: obj.id ?? "")
                    self.viewModel.fetchSuccessfully = { [] in
                        self.setupBinding()
                    }
                }
            }
        }
        
        return cell
    }
}
