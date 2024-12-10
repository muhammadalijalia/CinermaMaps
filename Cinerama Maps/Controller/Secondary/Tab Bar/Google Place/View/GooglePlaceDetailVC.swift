//
//  GooglePlaceDetailVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 06/11/24.
//

import UIKit
import LanguageManager_iOS

class GooglePlaceDetailVC: UIViewController {
    
    @IBOutlet weak var placeImg_Collection: UICollectionView!
    @IBOutlet weak var page_Controller: UIPageControl!
    @IBOutlet weak var lbl_PlaceName: UILabel!
    @IBOutlet weak var lbl_OpenCloseStatus: UILabel!
    @IBOutlet weak var lbl_Km: UILabel!
    @IBOutlet weak var lbl_PlaceDescription: UILabel!
    @IBOutlet weak var tag_Collection: UICollectionView!
    @IBOutlet weak var timeSchedule_Collection: UICollectionView!
    @IBOutlet weak var rating_TableVw: UITableView!
    
    @IBOutlet weak var lbl_PhoneNum: UILabel!
    @IBOutlet weak var lbl_WebsiteLink: UILabel!
    
    @IBOutlet weak var btn_LikeOt: UIButton!
    @IBOutlet weak var btn_DislikeOt: UIButton!
    
    @IBOutlet weak var lbl_WorthVisit: UILabel!
    @IBOutlet weak var lbl_WorthNotVisit: UILabel!
    
    var viewModel: GooglePlaceVM
    
//    var mapType:String = ""
//    var nameOfMap:String = ""
    var cityiD:String = ""
    
    var placeId:String = ""
    
    init(viewModel: GooglePlaceVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        // Provide a default ViewModel to avoid crash
        self.viewModel = GooglePlaceVM()  // Replace with proper default if needed
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tag_Collection.register(UINib(nibName: "TagCell", bundle: nil), forCellWithReuseIdentifier: "TagCell")
        self.timeSchedule_Collection.register(UINib(nibName: "TagCell", bundle: nil), forCellWithReuseIdentifier: "TagCell")
        self.rating_TableVw.register(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: "ReviewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bindDataToVC()
    }
    
    private func bindDataToVC() {
        viewModel.fetchPlaceId(vC: self)
        viewModel.generatedSuccessfull = { [self] generatedPlaceId in
            viewModel.fetchGooglePlaceDetail(vC: self, placeId: generatedPlaceId, tagCollection: tag_Collection, weekCollection: timeSchedule_Collection, ratingTable: rating_TableVw)
            
            viewModel.fetchedDetailSuccessfull = { [self] in
                DispatchQueue.main.async { [self] in
                    // Update UI with place details
                    let obj = self.viewModel.arrayPlaceDetail
                    self.lbl_PlaceName.text = obj?.place_name
                    lbl_Km.text = "Away from you \(obj?.distance ?? "") km"
                    self.cityiD = obj?.city_id ?? ""
                    self.placeId = obj?.placeid ?? ""
                    
                    self.lbl_WorthVisit.text = "\(obj?.total_fav_place ?? "") \("Worth a visit".localiz())"
                    self.lbl_WorthNotVisit.text = "\(obj?.total_unfav_place ?? "") \("Not Worth visit".localiz())"
                    
                    if obj?.fav_status == "Like" {
                        self.btn_LikeOt.tintColor = #colorLiteral(red: 0.2039215686, green: 0.6588235294, blue: 0.3254901961, alpha: 1)
                    } else if obj?.fav_status == "Unlike" {
                        self.btn_DislikeOt.tintColor = .red
                    } else {
                        self.btn_LikeOt.tintColor = .darkGray
                        self.btn_DislikeOt.tintColor = .darkGray
                    }
                    
                    if let html = obj?.description, let attributedText = html.htmlAttributedString3 {
                        lbl_PlaceDescription.attributedText = attributedText
                    }
                    
                    lbl_PhoneNum.text = viewModel.phoneNum
                    lbl_WebsiteLink.text = viewModel.websiteLink
                    
                    // Reload collections
                    tag_Collection.reloadData()
                    timeSchedule_Collection.reloadData()
                    rating_TableVw.reloadData()
                    
                    // Fetch and update photos
                    DispatchQueue.main.async { [self] in
                        viewModel.fetchPlacesPhotos(vC: self, placeId: obj?.placeid ?? "")
                        self.viewModel.fetchedPhotosSuccessfull = { [self] in
                            self.page_Controller.numberOfPages = self.viewModel.arrayGooglePhotos.count
                            self.placeImg_Collection.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_VideoLink(_ sender: UIButton) {
        
    }
    
    @IBAction func btn_Visit(_ sender: UIButton) {
        viewModel.requestToFavUnfavPlace(vC: self, status: "Like")
        viewModel.fetchedDetailSuccessfull = { [self] in
            self.bindDataToVC()
        }
    }
    
    @IBAction func btn_NotVisit(_ sender: UIButton) {
        viewModel.requestToFavUnfavPlace(vC: self, status: "Unlike")
        viewModel.fetchedDetailSuccessfull = { [self] in
            self.bindDataToVC()
        }
    }
    
    @IBAction func btn_AddTripSchedule(_ sender: UIButton) {
        viewModel.navigateToPlaceTableViewController(from: self.navigationController, cityiD: cityiD)
    }
    
    @IBAction func btn_ServiceEvaluation(_ sender: UIButton) {
        let vC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RatingVC") as! RatingVC
        navigationController?.pushViewController(vC, animated: true)
    }
    
}

extension GooglePlaceDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrayRatingReview.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
        
        let obj = self.viewModel.arrayRatingReview[indexPath.row]
        cell.lbl_Name.text = obj.user_name ?? ""
        cell.lbl_Date.text = obj.date_time ?? ""
        cell.ratingStar.rating = Double(obj.rating ?? "") ?? 0.0
        cell.ratingCount.text = obj.rating ?? ""
        cell.lbl_Message.text = obj.review ?? ""
        
        if Router.BASE_IMAGE_URL != obj.image {
            Utility.setImageWithSDWebImage(obj.image ?? "", cell.user_Img)
        } else {
            cell.user_Img.image = R.image.blank()
        }
        
        return cell
    }
}

extension GooglePlaceDetailVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == placeImg_Collection {
            viewModel.arrayGooglePhotos.count
        } else if collectionView == tag_Collection {
            viewModel.arrayPlaceTags.count
        } else {
            viewModel.arrayWeekDays.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == placeImg_Collection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ServiceDetailImageCell
            
            let obj = viewModel.arrayGooglePhotos[indexPath.row]
            
            if Router.BASE_IMAGE_URL != obj.p_photo {
                Utility.setImageWithSDWebImage(obj.p_photo ?? "", cell.place_Img)
            } else {
                cell.place_Img.image = R.image.blank()
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
            if collectionView == tag_Collection {
                let obj = viewModel.arrayPlaceTags[indexPath.row]
                cell.lbl_TagName.text = obj.tag_name ?? ""
                cell.lbl_TagName.backgroundColor = hexStringToUIColor(hex: obj.color_code ?? "")
            } else {
                let obj = viewModel.arrayWeekDays[indexPath.row]
                cell.lbl_TagName.text = obj
                cell.lbl_TagName.textColor = .black
                cell.lbl_TagName.font = UIFont(name: "Avenir", size: 12)
                cell.lbl_TagName.cornerRadius = 10
                cell.lbl_TagName.borderWidth = 0.5
                cell.lbl_TagName.borderColor = .separator
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == placeImg_Collection {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        } else if collectionView == tag_Collection {
            return CGSize(width: 127, height: collectionView.frame.height)
        } else {
            return CGSize(width: collectionView.frame.width / 2 - 6, height: 36)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == placeImg_Collection {
            return 0
        } else if collectionView == tag_Collection {
            return 10
        } else {
            return 6
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        page_Controller.currentPage = Int(pageIndex)
    }
}


