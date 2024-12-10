//
//  AllMapsDetailVC.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 28/08/24.
//

import Cosmos
import GoogleMaps
import SDWebImage

enum MapDetailTab: Int {
    case aboutMap = 0
    case place
    case review
    case images
}

class AllMapsDetailVC: UIViewController {
    
    @IBOutlet weak var lbl_MainHeadline: UILabel!
    
    //    Mark SubView Outlet
    @IBOutlet var labelLine1: UILabel!
    @IBOutlet var labelLine2: UILabel!
    @IBOutlet var labelLine3: UILabel!
    @IBOutlet var labelLine4: UILabel!
    
    //    Mark SubView Outlet
    @IBOutlet weak var btn_AboutMap: UIButton!
    @IBOutlet weak var btn_Place: UIButton!
    @IBOutlet weak var btn_Review: UIButton!
    @IBOutlet weak var btn_Images: UIButton!
    
    //    Mark SubView Outlet
    @IBOutlet weak var aboutCity_Vw: UIView!
    @IBOutlet weak var map_Vw: UIView!
    @IBOutlet weak var review_Vw: UIView!
    @IBOutlet weak var images_Vw: UIView!
    
    //    Mark SubView Outlet
    @IBOutlet weak var img_DetailMap: UIImageView!
    @IBOutlet weak var btn_FavUnfavOt: UIButton!
    @IBOutlet weak var lbl_CityNAme: UILabel!
    @IBOutlet weak var lbl_Amount: UILabel!
    @IBOutlet weak var ratingVw: CosmosView!
    @IBOutlet weak var lbl_RatingReview: UILabel!
    @IBOutlet weak var lbl_CityAddress: UILabel!
    
    //    Mark About City View Outlet's
    @IBOutlet weak var lbl_AboutCity: UILabel!
    @IBOutlet weak var lbl_Currrency: UILabel!
    @IBOutlet weak var lbl_Language: UILabel!
    @IBOutlet weak var lbl_Clothing: UILabel!
    @IBOutlet weak var lbl_Timing: UILabel!
    @IBOutlet weak var lbl_Health: UILabel!
    @IBOutlet weak var lbl_ElectricSocket: UILabel!
    @IBOutlet weak var lbl_Communication: UILabel!
    @IBOutlet weak var lbl_Weather: UILabel!
    @IBOutlet weak var lbl_PoliceCarNum: UILabel!
    @IBOutlet weak var lbl_PolicePhoneNum: UILabel!
    
    //    Mark MapView Outlet
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var locationAddress_Vw: UIView!
    @IBOutlet weak var lbl_PlaceName: UILabel!
    @IBOutlet weak var lbl_PlaceAddress: UILabel!
    
    //    Mark RatingView Outlet
    @IBOutlet weak var rating_TableVw: UITableView!
    
    //    Mark ImagesView Outlet
    @IBOutlet weak var images_CollectionVw: UICollectionView!
    
    @IBOutlet weak var btn_SubscribeOt: UIButton!
    @IBOutlet weak var mapZoom: UIStepper!
    
    
    var marklers:[CustomPointAnnotation] = []
    let viewModel = AllMapViewModel()
    var bounds = GMSCoordinateBounds()
    
    var isSubscribed:String = ""
    var countryMapiD:String = ""
    
    var totalAmount:String = ""
    var totalDuration:String = ""
    var type:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rating_TableVw.register(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: "ReviewCell")
        self.images_CollectionVw.register(UINib(nibName: "MapCell", bundle: nil), forCellWithReuseIdentifier: "MapCell")
        selectTab(.aboutMap)
        bindDataFromVm()
        self.locationAddress_Vw.isHidden = true
        self.mapView.delegate = self
        
        if isSubscribed == "Yes" {
            self.btn_SubscribeOt.isHidden = true
        } else {
            self.btn_SubscribeOt.isHidden = false
        }
    }
    
    @IBAction func allPlaceDetailButton(_ sender: UIButton) {
        guard let selectedTab = MapDetailTab(rawValue: sender.tag) else { return }
        selectTab(selectedTab)
    }
    
    private func selectTab(_ tab: MapDetailTab) {
        let selectedColor = hexStringToUIColor(hex: "#008200")
        let defaultColor = UIColor.darkGray
        
        btn_AboutMap.setTitleColor(tab == .aboutMap ? selectedColor : defaultColor, for: .normal)
        btn_Place.setTitleColor(tab == .place ? selectedColor : defaultColor, for: .normal)
        btn_Review.setTitleColor(tab == .review ? selectedColor : defaultColor, for: .normal)
        btn_Images.setTitleColor(tab == .images ? selectedColor : defaultColor, for: .normal)
        
        labelLine1.backgroundColor = tab == .aboutMap ? selectedColor : .clear
        labelLine2.backgroundColor = tab == .place ? selectedColor : .clear
        labelLine3.backgroundColor = tab == .review ? selectedColor : .clear
        labelLine4.backgroundColor = tab == .images ? selectedColor : .clear
        
        aboutCity_Vw.isHidden = tab != .aboutMap
        map_Vw.isHidden = tab != .place
        review_Vw.isHidden = tab != .review
        images_Vw.isHidden = tab != .images
    }
    
    @IBAction func btn_Subscribe(_ sender: UIButton) {
        viewModel.navigateToSubcribeViewController(from: self.navigationController, mapiD: countryMapiD, type: type, durationVal: totalDuration, amountVal: totalAmount)
    }
    
    @IBAction func btn_Back(_ sender: UIButton) {
        viewModel.returnBackk(from: self.navigationController)
    }
    
    @IBAction func btn_ClosePlaceDt(_ sender: UIButton) {
        self.locationAddress_Vw.isHidden = true
    }
    
    @IBAction func btn_FavUnfav(_ sender: UIButton) {
        
    }
    
    @IBAction func actZoomMap(_ sender: UIStepper) {
        guard let camera = mapView?.camera else { return }
        let newZoom = Float(sender.value)
        let updatedCamera = GMSCameraUpdate.zoom(to: newZoom)
        mapView.animate(with: updatedCamera)
    }
    private func bindDataFromVm()
    {
        viewModel.requestCountryMapDetails(vC: self)
        viewModel.fetchedSuccessfully = { [] in
            DispatchQueue.main.async {
                let obj = self.viewModel.arrayOfDetailCityMaps
                self.lbl_MainHeadline.text = obj?.name
                self.lbl_CityNAme.text = obj?.name
                self.lbl_Amount.text = "\(obj?.city_map_price ?? "") SAR for \(obj?.city_map_month ?? "") Month"
                self.ratingVw.rating = Double(obj?.place_details?[0].avg_rating ?? "") ?? 0.0
                self.lbl_RatingReview.text = obj?.place_details?[0].avg_rating ?? ""
                self.lbl_CityAddress.text = obj?.address
                self.lbl_AboutCity.text = obj?.about_city
                self.lbl_Currrency.text = obj?.currency
                self.lbl_Language.text = obj?.offical_language
                self.lbl_Clothing.text = obj?.clothing
                self.lbl_Timing.text = obj?.best_time_to_visit
                self.lbl_Health.text = obj?.health
                self.lbl_ElectricSocket.text = obj?.electrical_socket
                self.lbl_Communication.text = obj?.communications
                self.lbl_Weather.text = obj?.the_waether
                self.lbl_PoliceCarNum.text = obj?.car_police_number
                self.lbl_PolicePhoneNum.text = obj?.police_number
                
                self.countryMapiD = obj?.country_id ?? ""
                self.type = obj?.name ?? ""
                self.totalDuration = obj?.city_map_month ?? ""
                self.totalAmount = obj?.city_map_price ?? ""
                
                let placeImg = obj?.image
                let imageUrl = Router.BASE_IMAGE_URL + (placeImg ?? "")
                
                if Router.BASE_IMAGE_URL != imageUrl {
                    Utility.setImageWithSDWebImage(imageUrl, self.img_DetailMap)
                } else {
                    self.img_DetailMap.image = R.image.blank()
                }
                
                self.updateAnnotations()
                self.rating_TableVw.reloadData()
                self.images_CollectionVw.reloadData()
                self.mapZoom.minimumValue = 1
                self.mapZoom.maximumValue = 20
                self.mapZoom.stepValue = 1
                self.mapZoom.value = 12
            }
        }
    }
    
    func updateAnnotations() {
        mapView.clear()
        marklers = []
        for cityMap in viewModel.arrayOfDetailCityMaps.place_details ?? [] {
            let markerView: MapMarkerView = UIView.fromNib()
            let coordinate = CLLocationCoordinate2D (
                latitude: Double(cityMap.lat ?? "") ?? 0.0,
                longitude: Double(cityMap.lon ?? "") ?? 0.0
            )
            print (cityMap.lat ?? "")
            print (cityMap.lon ?? "")
            markerView.subviews.forEach { view in
                view.isHidden = false
            }
            if (cityMap.show_only_icon ?? "0") == "1" {
                
                let colors = getColors(tags: cityMap.tag_details ?? [])
                markerView.pinView.sliceColors = colors
                markerView.outerImg.tintColor = hexStringToUIColor(hex: cityMap.icon_background_color ?? "#ffffff")
                markerView.innerImg.tintColor = colors.first
                if let iconUrl = cityMap.icon{
                    Utility.imageWithSDWebImage(iconUrl, markerView.mapIcon)
                }
                if !(cityMap.promo_code_and_discount?.isEmpty ?? false) {
                    markerView.outerImg.tintColor = UIColor.hexStringToUIColor(hex: "#F1D280")
                }else {
                    markerView.outerImg.tintColor = .white
                }
            }else if (cityMap.show_only_icon ?? "0") == "0"{
                markerView.innerImg.isHidden = true
                markerView.pinView.isHidden = true
                markerView.mapIcon.isHidden = true
                markerView.outerImg.isHidden = false
                Utility.imageWithSDWebImage(cityMap.icon ?? "", markerView.outerImg)
            }
            
            let annotation = CustomPointAnnotation()
            annotation.position = coordinate
            annotation.title = cityMap.place_name
            //            annotation.imageName = cityMap.icon
            annotation.city_Address = cityMap.address
            annotation.iconView = markerView
            
            bounds = bounds.includingCoordinate(annotation.position)
            
            mapView.setMinZoom(1, maxZoom: 15)//prevent to over zoom on fit and animate if bounds be too small
            
//            let update = GMSCameraUpdate.fit(bounds, withPadding: 50)
//            mapView.animate(with: update)
            
            mapView.setMinZoom(1, maxZoom: 20)
//            mapView.animate(toZoom: 30)
            mapView.settings.zoomGestures = true
            if let firstCoordinate = viewModel.arrayOfDetailCityMaps.place_details?.first {
                let camera = GMSCameraPosition(latitude: Double(firstCoordinate.lat ?? "") ?? 0.0, longitude:  Double(firstCoordinate.lon ?? "") ?? 0.0, zoom: 11)
                mapView.animate(to: camera)
            }
            marklers.append(annotation)
            DispatchQueue.main.async { // Setting marker on mapview in main thread.
                annotation.map = self.mapView // Setting marker on Mapview
            }
           
            
        }
    }
    
    
    func getColors(tags: [Tag_details]) -> [UIColor]{
        var colors:[UIColor] = []
        for tag in tags{
            colors.append(UIColor.hexStringToUIColor(hex: tag.color_code ?? "#000000"))
        }
        return colors
    }
}

extension AllMapsDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.arrayOfReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
        
        let obj = self.viewModel.arrayOfReviews[indexPath.row]
        cell.lbl_Name.text = obj.user_name ?? ""
        cell.lbl_Date.text = obj.date_time ?? ""
        cell.lbl_Message.text = obj.review ?? ""
        cell.ratingStar.rating = Double(obj.rating ?? "") ?? 0.0
        cell.ratingCount.text = obj.rating ?? ""
        
        if Router.BASE_IMAGE_URL != obj.image {
            Utility.setImageWithSDWebImage(obj.image ?? "", cell.user_Img)
        } else {
            cell.user_Img.image = R.image.blank()
        }
        
        return cell
    }
}

extension AllMapsDetailVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.arrayOfPlaceImg.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MapCell", for: indexPath) as! MapCell
        
        let obj = self.viewModel.arrayOfPlaceImg[indexPath.row]
        cell.countryMap.isHidden = true
        cell.lbl_CountryName.isHidden = true
        if Router.BASE_IMAGE_URL != obj.image {
            Utility.setImageWithSDWebImage(obj.image ?? "", cell.CountryImage)
        } else {
            cell.CountryImage.image = R.image.blank()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.frame.width
        return CGSize(width: collectionWidth / 2, height: 110)
    }
}

extension AllMapsDetailVC: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let customMarker = marker as? CustomPointAnnotation else { return false }
        
        // Show details popup for the selected marker
        let cityName = customMarker.title ?? ""
        let cityAddress = customMarker.city_Address ?? ""
        let cityIcon = customMarker.imageName ?? ""
        showDetailsPopup(city_Name: cityName, city_Address: cityAddress, city_Icon: cityIcon)
        return true
    }
    
    func showDetailsPopup(city_Name: String, city_Address: String, city_Icon: String) {
        self.locationAddress_Vw.isHidden = false
        self.lbl_PlaceName.text = city_Name
        self.lbl_PlaceAddress.text = city_Address
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        let zoom = position.zoom
        let visibleRegion = mapView.projection.visibleRegion()
        let bounds = GMSCoordinateBounds(region: visibleRegion)

        // Toggle marker visibility based on zoom and bounds
        for marker in marklers {
            let isVisible = zoom >= 10 && bounds.contains(marker.position)
            marker.map = isVisible ? mapView : nil
        }
    }
    
}

//extension CustomPointAnnotation {
//    func setCustomIcon(from imageName: String) {
//        Utility.downloadImageBySDWebImage(imageName) { image, error in
//            if let image = image, error == nil {
//                let circularImage = image.circularImage(with: CGSize(width: 40, height: 40))
//                self.icon = circularImage
//            } else {
//                let placeholderImage = R.image.no_Image_Available()?.circularImage(with: CGSize(width: 40, height: 40))
//                self.icon = placeholderImage
//            }
//        }
//    }
//}

