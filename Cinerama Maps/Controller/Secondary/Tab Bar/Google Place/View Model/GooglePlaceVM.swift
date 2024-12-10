//
//  GooglePlaceVM.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 06/11/24.
//

import Foundation

class GooglePlaceVM {
    
    var generatedSuccessfull:((_ placeId: String) -> Void)?
    var val_Address:String = ""
    var place_Id:String = ""
    
    var fetchedDetailSuccessfull:(() -> Void)?
    var arrayPlaceDetail: Res_GooglePlaceDetail?
    var arrayMorePlaceDetails: Res_GoogePlaceResult?
    var arrayPlaceTags: [Tag_details] = []
    var arrayRatingReview: [Rating_review] = []
    var arrayWeekDays: [String] = []
    var lat:String = ""
    var lon:String = ""
    
    var phoneNum:String = ""
    var websiteLink:String = ""
    
    var fetchedPhotosSuccessfull:(() -> Void)?
    var arrayGooglePhotos: [Res_GooglePhotos] = []
    
    func fetchPlaceId(vC: UIViewController)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["address"] = val_Address as AnyObject
        paramDict["db_place_id"] = place_Id as AnyObject
        paramDict["lang"] = "en" as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToGeneratePlaceId(vC, paramDict) { responseData in
            if responseData.place_id != "" {
                self.generatedSuccessfull?(responseData.place_id ?? "")
            } else {
                print("Something went wrong")
            }
        }
    }
    
    func fetchGooglePlaceDetail(vC: UIViewController, placeId: String,tagCollection: UICollectionView, weekCollection: UICollectionView, ratingTable: UITableView)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["place_id"] = placeId as AnyObject
        paramDict["lang"] = "en" as AnyObject
        paramDict["lat"] = lat as AnyObject
        paramDict["lon"] = lon as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToGooplePlaceDetails(vC, paramDict) { responseData in
            self.arrayPlaceDetail = responseData
            self.arrayMorePlaceDetails = responseData.google_map?.result
            
            if let obj_TagDetails = responseData.tag_details {
                if obj_TagDetails.count > 0 {
                    self.arrayPlaceTags = obj_TagDetails
                    tagCollection.isHidden = false
                } else {
                    self.arrayPlaceTags = []
                    tagCollection.isHidden = true
                }
            } else {
                tagCollection.isHidden = true
            }
            
            if let obj_Weekdays = responseData.google_map?.result?.current_opening_hours?.weekday_text {
                if obj_Weekdays.count > 0 {
                    self.arrayWeekDays = obj_Weekdays
                    weekCollection.isHidden = false
                } else {
                    self.arrayWeekDays = []
                    weekCollection.isHidden = true
                }
            } else {
                weekCollection.isHidden = true
            }
            
            if let obj_RatingReview = responseData.rating_review {
                if obj_RatingReview.count > 0 {
                    self.arrayRatingReview = obj_RatingReview
                    ratingTable.isHidden = false
                } else {
                    self.arrayRatingReview = []
                    ratingTable.isHidden = true
                }
            } else {
                ratingTable.isHidden = true
            }
            
            if let obj_GooglePlace = responseData.google_map?.result {
                self.phoneNum = obj_GooglePlace.formatted_phone_number ?? ""
                self.websiteLink = obj_GooglePlace.website ?? ""
            }
            
            self.fetchedDetailSuccessfull?()
        }
    }
    
    func fetchPlacesPhotos(vC: UIViewController,placeId: String)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["place_id"] = placeId as AnyObject
        paramDict["lang"] = "en" as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToGooplePhotos(vC, paramDict) { [self] responseData in
            if responseData.count > 0 {
                self.arrayGooglePhotos = responseData
            } else {
                self.arrayGooglePhotos = []
            }
            self.fetchedPhotosSuccessfull?()
        }
    }
    
    func requestToFavUnfavPlace(vC: UIViewController, status: String)
    {
        var paramDict: [String : AnyObject] = [:]
        paramDict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject?
        paramDict["place_id"] = place_Id as AnyObject
        paramDict["status"] = status as AnyObject
        
        print(paramDict)
        
        Api.shared.requestToSelectFavUnFavPlace(vC, paramDict) { [self] responseData in
            if responseData.status == "1" {
                self.fetchedDetailSuccessfull?()
            } else {
                print("Api message: \(responseData.message ?? "")")
            }
        }
    }
    
    func navigateToPlaceTableViewController(from navigation: UINavigationController?, cityiD:String) {
        let vC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlaceTableVC") as! PlaceTableVC
        vC.viewModel.cityId = cityiD
        vC.viewModel.uiDependOn = "GoogleEdit"
        let obj = self.arrayPlaceDetail
        
        vC.addTripVM.trip_PlaceiD = obj?.id ?? ""
        vC.addTripVM.map_PlaceiD = obj?.placeid ?? ""
        vC.addTripVM.place_iD = obj?.city_id ?? ""
        vC.addTripVM.country_Id = obj?.country_details?.id ?? ""
        vC.addTripVM.country_Name = obj?.country_details?.name ?? ""
        vC.addTripVM.country_NameAr = obj?.country_details?.name_ar ?? ""
        vC.addTripVM.location = obj?.address ?? ""
        vC.addTripVM.valLat = Double(obj?.lat ?? "") ?? 0.0
        vC.addTripVM.valLon = Double(obj?.lon ?? "") ?? 0.0
        vC.addTripVM.mapType = obj?.city_details?.name ?? ""
        vC.addTripVM.map_TypeAr = obj?.city_details?.name_ar ?? ""
        vC.addTripVM.trip_Name = obj?.place_name ?? ""
        vC.addTripVM.trip_NameAr = obj?.place_name_ar ?? ""
        
        vC.addTripVM.day_Id = vC.viewModel.dayiD
        vC.addTripVM.day_Name = vC.viewModel.dayName
        vC.addTripVM.day_NameAr = vC.viewModel.dayNameAr
        vC.addTripVM.table_map_name = vC.viewModel.mapType
        vC.addTripVM.isCNRM = vC.byCNRM
        navigation?.pushViewController(vC, animated: true)
    }
}
