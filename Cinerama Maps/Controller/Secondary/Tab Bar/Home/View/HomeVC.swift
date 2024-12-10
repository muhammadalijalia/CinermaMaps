//
//  HomeVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 22/08/24.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var profile_Img: UIImageView!
    @IBOutlet weak var lbl_UserName: UILabel!
    
    @IBOutlet weak var service_CollectionVw: UICollectionView!
    @IBOutlet weak var map_CollectionVw: UICollectionView!
    @IBOutlet weak var guideline_CollectionVw: UICollectionView!
    @IBOutlet weak var advertisementCollection: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var advertisementPage: UIPageControl!
    
    let viewModel = HomeViewModel()
    let countryMapVM = CountryMapApiViewModel()
    let guidelinesTipVM = GuidelineTipApiViewModel()
    let serviceVM = ServiceApiViewModel()
    let advertisementVM = AdvertisementViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerResuableCellIdentifier()
        requestCountryMap()
        requestGuidelineTip()
        requestServices()
        requestBanners()
        fetchProfileDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func btn_Search(_ sender: UIButton) {
        let vC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapVC") as! MapVC
        vC.decided_Ui = "Search"
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_MapsMore(_ sender: UIButton) {
        let vC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapVC") as! MapVC
        vC.decided_Ui = "Search"
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func btn_Setting(_ sender: UIButton) {
        viewModel.navigateToSettingViewController(from: self.navigationController)
    }
    
    @IBAction func btn_Notify(_ sender: UIButton) {
        viewModel.navigateToNotificationViewController(from: self.navigationController)
    }
    
    @IBAction func btn_AddTrip(_ sender: UIButton) {
        viewModel.navigateToTripViewController(from: self.navigationController)
    }
    
    private func fetchProfileDetail()
    {
        viewModel.fetchUserProfileDetails(vC: self)
        viewModel.fetchSuccessfully = { [] in
            DispatchQueue.main.async { [self] in
                let obj = self.viewModel.arrayUserProfile
                self.lbl_UserName.text = "\(obj?.first_name ?? "") \(obj?.last_name ?? "")"
                
                if Router.BASE_IMAGE_URL != obj?.image {
                    Utility.setImageWithSDWebImage(obj?.image ?? "", self.profile_Img)
                } else {
                    self.profile_Img.image = R.image.profile_ic()
                }
            }
        }
    }
    
    private func requestCountryMap()
    {
        countryMapVM.fetchCountryMaps(vC: self)
        countryMapVM.fethcedSuccessfully = { [] in
            DispatchQueue.main.async {
                self.map_CollectionVw.reloadData()
            }
        }
    }
    
    private func requestGuidelineTip()
    {
        guidelinesTipVM.fetchGuidelineTips(vC: self)
        guidelinesTipVM.fethcedSuccessfully = { [] in
            DispatchQueue.main.async {
                self.guideline_CollectionVw.reloadData()
            }
        }
    }
    
    private func requestServices()
    {
        serviceVM.requestToServices(vC: self)
        serviceVM.fetchedSuccesfully = { [] in
            DispatchQueue.main.async {
                self.pageControl.numberOfPages = self.serviceVM.arrayOfImages.count
                self.service_CollectionVw.reloadData()
            }
        }
    }
    
    private func requestBanners()
    {
        advertisementVM.requestToFetchAdvertisement(vC: self)
        advertisementVM.fetchedSuccessfully = { [] in
            DispatchQueue.main.async {
                self.advertisementPage.numberOfPages = self.advertisementVM.arrayOfBanners.count
                self.advertisementCollection.reloadData()
            }
        }
    }
}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func registerResuableCellIdentifier()
    {
        self.service_CollectionVw.register(UINib(nibName: "ServiceCell", bundle: nil), forCellWithReuseIdentifier: "ServiceCell")
        self.advertisementCollection.register(UINib(nibName: "ServiceCell", bundle: nil), forCellWithReuseIdentifier: "ServiceCell")
        self.map_CollectionVw.register(UINib(nibName: "MapCell", bundle: nil), forCellWithReuseIdentifier: "MapCell")
        self.guideline_CollectionVw.register(UINib(nibName: "GuidelineCell", bundle: nil), forCellWithReuseIdentifier: "GuidelineCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == advertisementCollection {
            return self.advertisementVM.arrayOfBanners.count
        } else if collectionView == service_CollectionVw {
            return serviceVM.arrayOfImages.count
        } else if collectionView == map_CollectionVw {
            return self.countryMapVM.arrayCountryMaps.count
        } else {
            return guidelinesTipVM.arrayGuidelinesTip.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == advertisementCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCell", for: indexPath) as! ServiceCell
            let obj = self.advertisementVM.arrayOfBanners[indexPath.row]
            
            if Router.BASE_IMAGE_URL != obj.image {
                Utility.setImageWithSDWebImage(obj.image ?? "", cell.service_Img)
            } else {
                cell.service_Img.image = R.image.blank()
            }
            
            return cell
        } else if collectionView == service_CollectionVw {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCell", for: indexPath) as! ServiceCell
            let obj_Image = serviceVM.arrayOfImages[indexPath.row]
            print(obj_Image)
            Utility.setImageWithSDWebImage(obj_Image, cell.service_Img)
            return cell
        } else if collectionView == map_CollectionVw {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MapCell", for: indexPath) as! MapCell
            
            let obj = countryMapVM.arrayCountryMaps[indexPath.row]
            cell.lbl_CountryName.text = obj.name ?? ""
            
            if Router.BASE_IMAGE_URL != obj.image {
                Utility.setImageWithSDWebImage(obj.image ?? "", cell.CountryImage)
            } else {
                cell.CountryImage.image = R.image.blank()
            }
            
            if Router.BASE_IMAGE_URL != obj.country_icon {
                Utility.setImageWithSDWebImage(obj.country_icon ?? "", cell.countryMap)
            } else {
                cell.CountryImage.image = R.image.blank()
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GuidelineCell", for: indexPath) as! GuidelineCell
            
            let obj = self.guidelinesTipVM.arrayGuidelinesTip[indexPath.row]
            
            cell.lbl_Text.text = obj.title ?? ""
            
            if Router.BASE_IMAGE_URL != obj.image {
                Utility.setImageWithSDWebImage(obj.image ?? "", cell.img)
            } else {
                cell.img.image = R.image.blank()
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == service_CollectionVw || collectionView == advertisementCollection {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        } else if collectionView == map_CollectionVw {
            return CGSize(width: 130, height: collectionView.frame.height)
        } else {
            return CGSize(width: 180, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == service_CollectionVw {
            let obj = serviceVM.arrayOfServices[0]
            self.viewModel.navigateToServicesViewController(from: self.navigationController, service_Id: obj.id ?? "")
        } else if collectionView == map_CollectionVw {
            let obj = countryMapVM.arrayCountryMaps[indexPath.row]
            self.viewModel.navigateToCityMapsViewController(from: self.navigationController, countryId: obj.id ?? "")
        } else if collectionView == guideline_CollectionVw {
            let obj = self.guidelinesTipVM.arrayGuidelinesTip[indexPath.row]
            self.viewModel.navigateToGuidlineViewController(from: self.navigationController, title: obj.title ?? "", dateTime: obj.date_time ?? "", description: obj.description ?? "", image: obj.image ?? "")
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
