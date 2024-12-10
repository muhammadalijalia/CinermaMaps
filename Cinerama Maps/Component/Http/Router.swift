//
//  Router.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 02/09/24.
//

import Foundation

enum Router: String {
    
    static let BASE_SERVICE_URL = "https://cinmap.innovatechagency.tech/Webservice/"
    static let BASE_IMAGE_URL = "http://35.183.250.236/CineramaMaps/uploads/images/"
    
    case send_otp
    case signup
    
    case get_profile
    case get_country_map
    case get_country_map_city
    case get_guidelines_tips
    case get_services
    case get_company_offer
    case get_country_map_city_places
    case get_user_trip_schedule
    case get_user_trip_schedule_details
    case get_purcahse_city_map_list
    case get_service_details
    case my_fav_citymap
    
    case get_place_id_by_addresss_googlemap
    case get_details_by_place_id_googlemap
    case get_photos_by_place_id_googlemap
    case get_user_trip_schedule_by_day
    case get_user_trip_schedule_map_name
    case get_days
    case get_banner
    case get_notification_list
    
    case add_user_trip_schedule
    case add_service_rating_review
    case add_country_map_suggestion
    case fav_unfav_citymap
    case update_user_trip_schedule
    case fav_unfav_place
    
    case addPayment_moyasar
    case plan_purchase
    
    case cancel_plan_purchase
    
    case delete_user_trip_schedule_by_city
    case delete_user_trip_schedule
    
    public func url() -> String {
        switch self {
        case .send_otp:
            return Router.oAuthPath(path: "send_otp")
        case .signup:
            return Router.oAuthPath(path: "signup")
            
        case .get_profile:
            return Router.oAuthPath(path: "get_profile")
        case .get_services:
            return Router.oAuthPath(path: "get_services")
        case .get_country_map:
            return Router.oAuthPath(path: "get_country_map")
        case .get_country_map_city:
            return Router.oAuthPath(path: "get_country_map_city")
        case .get_guidelines_tips:
            return Router.oAuthPath(path: "get_guidelines_tips")
        case .get_company_offer:
            return Router.oAuthPath(path: "get_company_offer")
        case .get_country_map_city_places:
            return Router.oAuthPath(path: "get_country_map_city_places")
        case .get_user_trip_schedule:
            return Router.oAuthPath(path: "get_user_trip_schedule")
        case .get_user_trip_schedule_details:
            return Router.oAuthPath(path: "get_user_trip_schedule_details")
        case .get_purcahse_city_map_list:
            return Router.oAuthPath(path: "get_purcahse_city_map_list")
        case .get_service_details:
            return Router.oAuthPath(path: "get_service_details")
            
        case .get_place_id_by_addresss_googlemap:
            return Router.oAuthPath(path: "get_place_id_by_addresss_googlemap")
        case .get_details_by_place_id_googlemap:
            return Router.oAuthPath(path: "get_details_by_place_id_googlemap")
        case .get_photos_by_place_id_googlemap:
            return Router.oAuthPath(path: "get_photos_by_place_id_googlemap")
        case .get_user_trip_schedule_by_day:
            return Router.oAuthPath(path: "get_user_trip_schedule_by_day")
        case .get_user_trip_schedule_map_name:
            return Router.oAuthPath(path: "get_user_trip_schedule_map_name")
        case .get_days:
            return Router.oAuthPath(path: "get_days")
        case .get_banner:
            return Router.oAuthPath(path: "get_banner")
        case .get_notification_list:
            return Router.oAuthPath(path: "get_notification_list")
            
        case .add_service_rating_review:
            return Router.oAuthPath(path: "add_service_rating_review")
        case .add_country_map_suggestion:
            return Router.oAuthPath(path: "add_country_map_suggestion")
        case .fav_unfav_citymap:
            return Router.oAuthPath(path: "fav_unfav_citymap")
        case .my_fav_citymap:
            return Router.oAuthPath(path: "my_fav_citymap")
        case .add_user_trip_schedule:
            return Router.oAuthPath(path: "add_user_trip_schedule")
        case .update_user_trip_schedule:
            return Router.oAuthPath(path: "update_user_trip_schedule")
        case .fav_unfav_place:
            return Router.oAuthPath(path: "fav_unfav_place")
            
        case .cancel_plan_purchase:
            return Router.oAuthPath(path: "cancel_plan_purchase")
            
        case .delete_user_trip_schedule_by_city:
            return Router.oAuthPath(path: "delete_user_trip_schedule_by_city")
        case .delete_user_trip_schedule:
            return Router.oAuthPath(path: "delete_user_trip_schedule")
       
        case .addPayment_moyasar:
            return Router.oAuthPath(path: "addPayment_moyasar")
        case .plan_purchase:
            return Router.oAuthPath(path: "plan_purchase")
        }
    }
    
    private static func oAuthPath(path: String) -> String {
        return Router.BASE_SERVICE_URL + path
    }
}
