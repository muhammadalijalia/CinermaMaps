//
//  Api.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 02/09/24.
//

import Foundation

class Api: NSObject {
    
    static let shared = Api()
    
    func paramGetUserId() -> [String : AnyObject]
    {
        var dict: [String : AnyObject] = [:]
        dict["user_id"] = k.userDefault.value(forKey: k.session.userId) as AnyObject
        return dict
    }
    
    func requestOtpToVerifyNum(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Api_SendOtp) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.send_otp.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_SendOtp.self, from: response)
                if root.result != nil {
                    success(root)
                } else {
                    k.userDefault.set(false, forKey: k.session.status)
                    k.userDefault.set(k.emptyString, forKey: k.session.userId)
                    k.userDefault.set(k.emptyString, forKey: k.session.userEmail)
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func signup(_ vc: UIViewController, _ params: [String: String], images: [String : UIImage?]?, videos: [String : Data?]?, _ success: @escaping(_ responseData : Res_Signup) -> Void) {
        vc.showProgressBar()
        Service.postSingleMedia(url: Router.signup.url(), params: params, imageParam: images, videoParam: videos, parentViewController: vc, successBlock: { (responseData) in
            do {
                let decoder = JSONDecoder()
                let root = try decoder.decode(Api_Signup.self, from: responseData)
                if root.status == "1" {
                    vc.hideProgressBar()
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vc.hideProgressBar()
                    vc.alert(alertmessage: root.message ?? "Something went wrong")
                }
            } catch {
                vc.hideProgressBar()
                print(error)
            }
            vc.hideProgressBar()
        }) { (error: Error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.hideProgressBar()
        }
    }
    
    func requestUserProfile(_ vC: UIViewController,_ success: @escaping(_ responseData: Res_UserProfile) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_profile.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_UserProfile.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
                    print(vC.alert(alertmessage: root.message ??  ""))
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestCountryMap(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: [Res_CountryMap]) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_country_map.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_CountryMap.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestCityMap(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: [Res_CityMap]) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_country_map_city.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_CityMaps.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
                    print(vC.alert(alertmessage: "No data Available"))
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestGuidelineTips(_ vC: UIViewController,_ success: @escaping(_ responseData: [Res_GuidelineTips]) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_guidelines_tips.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_GuidelinesTips.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestAllServices(_ vC: UIViewController,_ success: @escaping(_ responseData: [Res_Services]) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_services.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_Services.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestCompanyOffers(_ vC: UIViewController,_ success: @escaping(_ responseData: [Res_Offers]) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_company_offer.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_AllOffers.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestCityPlaceDt(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_CityPlaceDetails) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_country_map_city_places.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_CityPlaceDetails.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
                vC.hideProgressBar()
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestScheduleTrip(_ vC: UIViewController,_ success: @escaping(_ responseData: [Res_ScheduleTrip]) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_user_trip_schedule.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_ScheduleTrip.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestDetailsScheduleTrip(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_DetailScheduleTrip) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_user_trip_schedule_details.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_DetailScheduleTrip.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToSelectFavUnFavCityMap(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Api_BasicModel) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.fav_unfav_citymap.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_BasicModel.self, from: response)
                if root.result != nil {
                    success(root)
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToSelectFavUnFavPlace(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Api_BasicModel) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.fav_unfav_place.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_BasicModel.self, from: response)
                if root.result != nil {
                    success(root)
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToPurchasedCityMap(_ vC: UIViewController,_ success: @escaping(_ responseData: [Res_PurchasedCityMap]) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_purcahse_city_map_list.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_PurchasedCityMaps.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToFavCityMap(_ vC: UIViewController,_ success: @escaping(_ responseData: [Res_FavCityMaps]) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.my_fav_citymap.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_FavCityMaps.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToSuggest(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_Suggestion) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.add_country_map_suggestion.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_Suggestion.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToServiceDetail(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_ServiceDetails) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_service_details.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_ServiceDetails.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToAddServiceRating(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_ServiceRating) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.add_service_rating_review.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_ServiceRating.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                    }
                } else {
                    vC.hideProgressBar()
                    vC.alert(alertmessage: root.message ?? "")
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToAddScheduleTrip(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_DetailScheduleTrip) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.add_user_trip_schedule.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_DetailScheduleTrip.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToUpdateScheduleTrip(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_DetailScheduleTrip) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.update_user_trip_schedule.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_DetailScheduleTrip.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToCancelSubcription(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Api_BasicModel) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.cancel_plan_purchase.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_BasicModel.self, from: response)
                if root.result != nil {
                    success(root)
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToGeneratePlaceId(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_GenerateGMPI) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_place_id_by_addresss_googlemap.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_GenerateGMPI.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToGooplePlaceDetails(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_GooglePlaceDetail) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_details_by_place_id_googlemap.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_GooglePlaceDetail.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToGooplePhotos(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: [Res_GooglePhotos]) -> Void) {
           vC.showProgressBar()
           Service.post(url: Router.get_photos_by_place_id_googlemap.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
               do {
                   let jsonDecoder = JSONDecoder()
                   let root = try jsonDecoder.decode(Api_GooglePhotos.self, from: response)
                   if root.status == "1" {
                       if let result = root.result {
                           success(result)
                           vC.hideProgressBar()
                       }
                   } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToMoreAboutTrip(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: [Res_MoreAboutTrip]) -> Void) {
           vC.showProgressBar()
           Service.post(url: Router.get_user_trip_schedule_by_day.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
               do {
                   let jsonDecoder = JSONDecoder()
                   let root = try jsonDecoder.decode(Api_MoreAboutTrip.self, from: response)
                   if root.status == "1" {
                       if let result = root.result {
                           success(result)
                           vC.hideProgressBar()
                       }
                   } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToDeleteTripSchedule(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Api_BasicModel) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.delete_user_trip_schedule.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_BasicModel.self, from: response)
                if root.result != nil {
                    success(root)
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToScheduleTripMapName(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: [Res_ScheduleTripMapName]) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_user_trip_schedule_map_name.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_ScheduleTripMapName.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
                    vC.hideProgressBar()
                    print(root.message ?? "")
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToDaySelection(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: [Res_DaysSelection]) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_days.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_DaysSelection.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
                    print(vC.alert(alertmessage: "No data Available"))
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToNotification(_ vC: UIViewController,_ success: @escaping(_ responseData: [Res_Notification]) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_notification_list.url(), params: paramGetUserId(), method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_Notification.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
                    print(vC.alert(alertmessage: "No data Available"))
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToAdvertismentBanner(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: [Res_Banner]) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.get_banner.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_Banner.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
                    print(vC.alert(alertmessage: "No data Available"))
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToAddPayment(_ vc: UIViewController, _ params: [String: AnyObject], _ success: @escaping(_ responseData : AnyObject) -> Void) {
        vc.blockUi()
        Service.callPostService(apiUrl: Router.addPayment_moyasar.url(), parameters: params, Method: .get, parentViewController: vc, successBlock: { (response, message) in
            success(response)
            vc.unBlockUi()
        }) { (error) in
            vc.alert(alertmessage: error.localizedDescription)
            vc.unBlockUi()
        }
    }
    
    func requestToPurchasePlan(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Res_PurchasePlan) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.plan_purchase.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_PurchasePlan.self, from: response)
                if root.status == "1" {
                    if let result = root.result {
                        success(result)
                        vC.hideProgressBar()
                    }
                } else {
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
    
    func requestToDeleteCityTrip(_ vC: UIViewController,_ param: [String : AnyObject],_ success: @escaping(_ responseData: Api_BasicModel) -> Void) {
        vC.showProgressBar()
        Service.post(url: Router.delete_user_trip_schedule_by_city.url(), params: param, method: .get, vc: vC, successBlock: { (response) in
            do {
                let jsonDecoder = JSONDecoder()
                let root = try jsonDecoder.decode(Api_BasicModel.self, from: response)
                if root.result != nil {
                    success(root)
                } else {
                    print("No Data Available to show!!")
                    vC.hideProgressBar()
                }
                vC.hideProgressBar()
            } catch {
                print(error)
            }
        }) { (error: Error) in
            vC.alert(alertmessage: error.localizedDescription)
            vC.hideProgressBar()
        }
    }
}
