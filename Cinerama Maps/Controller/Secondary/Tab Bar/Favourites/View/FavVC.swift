//
//  FavVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 22/08/24.
//

import UIKit
import LanguageManager_iOS

class FavVC: UIViewController {

    @IBOutlet weak var fav_TableVw: UITableView!
    @IBOutlet weak var search_Bar: UISearchBar!
    
    let viewModel = FavCityMapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        self.fav_TableVw.register(UINib(nibName: "CityMapCell", bundle: nil), forCellReuseIdentifier: "CityMapCell")
        self.setUpBindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setupSearchBar() {
        search_Bar.placeholder = "Search".localiz()
        search_Bar.barTintColor = UIColor.white
        search_Bar.searchTextField.backgroundColor = UIColor.white
        search_Bar.searchTextField.textColor = UIColor.black
        
        if let clearButton = search_Bar.searchTextField.value(forKey: "_clearButton") as? UIButton {
            clearButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        }
        
        search_Bar.layer.cornerRadius = 10
        search_Bar.layer.masksToBounds = true
    }
    
    func setUpBindViewModel()
    {
        viewModel.fetchFavCityMap(vC: self)
        viewModel.fetchedSuccessfull = { [] in
            DispatchQueue.main.async {
                self.fav_TableVw.reloadData()
            }
        }
    }
}

extension FavVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.arrayOfFavCityMap.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityMapCell", for: indexPath) as! CityMapCell
        
        let obj = self.viewModel.arrayOfFavCityMap[indexPath.row]
        cell.lbl_CountryName.text = obj.name ?? ""
        cell.lbl_Rating.text = obj.avg_rating ?? ""
        cell.lbl_Address.text = obj.address ?? ""
        cell.rating_Vw.rating = Double(obj.avg_rating ?? "") ?? 0.0
        
        if Router.BASE_IMAGE_URL != obj.image {
            Utility.setImageWithSDWebImage(obj.image ?? "", cell.img)
        } else {
            cell.img.image = R.image.blank()
        }
        
        if obj.fav_status == "Yes" {
            cell.btn_FavOt.tintColor = R.color.main()
        } else {
            cell.btn_FavOt.tintColor = .lightGray
        }
        
        cell.cloFav = { [] in
            self.viewModel.fetchFavAndUnFavMap(vC: self, cityId: obj.id ?? "")
            self.viewModel.fetchedSuccessfull = { [] in
                self.setUpBindViewModel()
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.viewModel.arrayOfFavCityMap[indexPath.row]
        viewModel.navigateToSubscriptionViewController(from: self.navigationController, cityId: obj.id ?? "")
    }
}
