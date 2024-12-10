//
//  NotifyVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 23/08/24.
//

import UIKit

class NotifyVC: UIViewController {

    @IBOutlet weak var notification_TableVw: UITableView!
    
    let viewModel: NotificationViewModel
    
    init(viewModel: NotificationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = NotificationViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.notification_TableVw.register(UINib(nibName: "NotifyCell", bundle: nil), forCellReuseIdentifier: "NotifyCell")
        fetchDataFromViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func fetchDataFromViewModel()
    {
        viewModel.requestToFetchNotificaiton(vC: self)
        viewModel.fetchedSuccessfull = { [] in
            DispatchQueue.main.async { [self] in
                self.notification_TableVw.reloadData()
            }
        }
    }
}

extension NotifyVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrayOfNotification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotifyCell", for: indexPath) as! NotifyCell
        let obj = viewModel.arrayOfNotification[indexPath.row]
        cell.lbl_MessageTitle.text = obj.title ?? ""
        cell.lbl_Message.text = obj.message ?? ""
        cell.lbl_DateTime.text = obj.date_time ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
