//
//  TripScheduleVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 23/08/24.
//

import UIKit
import LanguageManager_iOS

class TripScheduleVC: UIViewController {
    
    @IBOutlet weak var trip_TableVw: UITableView!
    private var viewModel: ScheduleTripViewModel
    
    init(viewModel: ScheduleTripViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        // Provide a default ViewModel to avoid crash
        self.viewModel = ScheduleTripViewModel()  // Replace with proper default if needed
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.trip_TableVw.register(UINib(nibName: "TripScheduleCell", bundle: nil), forCellReuseIdentifier: "TripScheduleCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        setupBinding()
    }
    
    @IBAction func btn_CreateSchedule(_ sender: Any) {
        let vC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SetUpTripScheduleVC") as! SetUpTripScheduleVC
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupBinding()
    {
        viewModel.fetchScheduleTrip(vC: self)
        viewModel.fethcedSuccessfully = { [self] in
            self.trip_TableVw.reloadData()
        }
    }
}

extension TripScheduleVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrayOfScheduleTrip.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripScheduleCell", for: indexPath) as! TripScheduleCell
        let obj = viewModel.arrayOfScheduleTrip[indexPath.row]
        
        cell.lbl_Address.text = "\(obj.map_type ?? ""), \(obj.country_name ?? "")"
        cell.lbl_ScheduleTrip.text = obj.map_name ?? ""
        
        if obj.trip_by_cineramap == "Yes" {
            cell.lbl_CreatedBy.isHidden = false
            cell.lbl_CreatedBy.text = "Created by Cineramamap".localiz()
        } else {
            cell.lbl_CreatedBy.isHidden = true
        }
        
        cell.lbl_Date.text = "Last Update: \(obj.date_time ?? "")"
        
        cell.cloDelete = { [self] in
            self.viewModel.deleteTripSchedule(vC: self, trip_iD: obj.id ?? "")
            self.viewModel.fethcedSuccessfully = { [self] in
                self.setupBinding()
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = viewModel.arrayOfScheduleTrip[indexPath.row]
        self.viewModel.navigateToMoreAboutViewController(from: self.navigationController, tableName: obj.map_name ?? "", cityiD: obj.place_id ?? "")
    }
}
