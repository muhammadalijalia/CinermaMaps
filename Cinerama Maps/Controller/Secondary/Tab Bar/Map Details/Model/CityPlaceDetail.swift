//
//  CityPlaceDetail.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 05/09/24.
//

import Foundation

struct Api_CityPlaceDetails : Codable {
    let result : Res_CityPlaceDetails?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Res_CityPlaceDetails.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct Res_CityPlaceDetails : Codable {
    let id : String?
    let country_id : String?
    let tag_id : String?
    let name : String?
    let name_ar : String?
    let about_city : String?
    let about_city_ar : String?
    let tag : String?
    let tag_ar : String?
    let image : String?
    let currency : String?
    let currency_ar : String?
    let clothing : String?
    let clothing_ar : String?
    let health : String?
    let health_ar : String?
    let communications : String?
    let communications_ar : String?
    let offical_language : String?
    let offical_language_ar : String?
    let best_time_to_visit : String?
    let best_time_to_visit_ar : String?
    let electrical_socket : String?
    let electrical_socket_ar : String?
    let the_waether : String?
    let the_waether_ar : String?
    let car_police_number : String?
    let police_number : String?
    let address : String?
    let lat : String?
    let lon : String?
    let date_time : String?
    let city_map_price : String?
    let city_map_month : String?
    let remove_status : String?
    let places_images : [Places_images]?
    let rating_review : [Rating_review]?
    let place_details : [Place_details]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case country_id = "country_id"
        case tag_id = "tag_id"
        case name = "name"
        case name_ar = "name_ar"
        case about_city = "about_city"
        case about_city_ar = "about_city_ar"
        case tag = "tag"
        case tag_ar = "tag_ar"
        case image = "image"
        case currency = "currency"
        case currency_ar = "currency_ar"
        case clothing = "clothing"
        case clothing_ar = "clothing_ar"
        case health = "health"
        case health_ar = "health_ar"
        case communications = "communications"
        case communications_ar = "communications_ar"
        case offical_language = "offical_language"
        case offical_language_ar = "offical_language_ar"
        case best_time_to_visit = "best_time_to_visit"
        case best_time_to_visit_ar = "best_time_to_visit_ar"
        case electrical_socket = "electrical_socket"
        case electrical_socket_ar = "electrical_socket_ar"
        case the_waether = "the_waether"
        case the_waether_ar = "the_waether_ar"
        case car_police_number = "car_police_number"
        case police_number = "police_number"
        case address = "address"
        case lat = "lat"
        case lon = "lon"
        case date_time = "date_time"
        case places_images = "places_images"
        case rating_review = "rating_review"
        case place_details = "place_details"
        case city_map_price = "city_map_price"
        case city_map_month = "city_map_month"
        case remove_status = "remove_status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
        tag_id = try values.decodeIfPresent(String.self, forKey: .tag_id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        name_ar = try values.decodeIfPresent(String.self, forKey: .name_ar)
        about_city = try values.decodeIfPresent(String.self, forKey: .about_city)
        about_city_ar = try values.decodeIfPresent(String.self, forKey: .about_city_ar)
        tag = try values.decodeIfPresent(String.self, forKey: .tag)
        tag_ar = try values.decodeIfPresent(String.self, forKey: .tag_ar)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        currency_ar = try values.decodeIfPresent(String.self, forKey: .currency_ar)
        clothing = try values.decodeIfPresent(String.self, forKey: .clothing)
        clothing_ar = try values.decodeIfPresent(String.self, forKey: .clothing_ar)
        health = try values.decodeIfPresent(String.self, forKey: .health)
        health_ar = try values.decodeIfPresent(String.self, forKey: .health_ar)
        communications = try values.decodeIfPresent(String.self, forKey: .communications)
        communications_ar = try values.decodeIfPresent(String.self, forKey: .communications_ar)
        offical_language = try values.decodeIfPresent(String.self, forKey: .offical_language)
        offical_language_ar = try values.decodeIfPresent(String.self, forKey: .offical_language_ar)
        best_time_to_visit = try values.decodeIfPresent(String.self, forKey: .best_time_to_visit)
        best_time_to_visit_ar = try values.decodeIfPresent(String.self, forKey: .best_time_to_visit_ar)
        electrical_socket = try values.decodeIfPresent(String.self, forKey: .electrical_socket)
        electrical_socket_ar = try values.decodeIfPresent(String.self, forKey: .electrical_socket_ar)
        the_waether = try values.decodeIfPresent(String.self, forKey: .the_waether)
        the_waether_ar = try values.decodeIfPresent(String.self, forKey: .the_waether_ar)
        car_police_number = try values.decodeIfPresent(String.self, forKey: .car_police_number)
        police_number = try values.decodeIfPresent(String.self, forKey: .police_number)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        places_images = try values.decodeIfPresent([Places_images].self, forKey: .places_images)
        rating_review = try values.decodeIfPresent([Rating_review].self, forKey: .rating_review)
        place_details = try? values.decodeIfPresent([Place_details].self, forKey: .place_details)
        city_map_price = try values.decodeIfPresent(String.self, forKey: .city_map_price)
        city_map_month = try values.decodeIfPresent(String.self, forKey: .city_map_month)
        remove_status = try values.decodeIfPresent(String.self, forKey: .remove_status)
    }
}

struct Place_details : Codable {
    let id : String?
    let user_id : String?
    let placeid : String?
    let country_id : String?
    let city_id : String?
    let tag_id : String?
    let place_name : String?
    let place_name_ar : String?
    let description : String?
    let description_ar : String?
    let tag : String?
    let tag_ar : String?
    let address : String?
    let lat : String?
    let lon : String?
    let icon : String?
    let icon_background_color : String?
    let show_only_icon : String?
    let promo_code_and_discount : String?
    let mobile : String?
    let email : String?
    let site_url : String?
    let video_link_en : String?
    let video_link_ar : String?
    let google_map_link : String?
    let date_time : String?
    let fav_status : String?
    let total_unfav_place : String?
    let total_fav_place : String?
    let country_name : String?
    let country_name_ar : String?
    let city_name : String?
    let city_name_ar : String?
    let avg_rating : String?
    let plan_purchase_status : String?
    let tag_details : [Tag_details]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case placeid = "placeid"
        case country_id = "country_id"
        case city_id = "city_id"
        case tag_id = "tag_id"
        case place_name = "place_name"
        case place_name_ar = "place_name_ar"
        case description = "description"
        case description_ar = "description_ar"
        case tag = "tag"
        case tag_ar = "tag_ar"
        case address = "address"
        case lat = "lat"
        case lon = "lon"
        case icon = "icon"
        case icon_background_color = "icon_background_color"
        case show_only_icon = "show_only_icon"
        case promo_code_and_discount = "promo_code_and_discount"
        case mobile = "mobile"
        case email = "email"
        case site_url = "site_url"
        case video_link_en = "video_link_en"
        case video_link_ar = "video_link_ar"
        case google_map_link = "google_map_link"
        case date_time = "date_time"
        case fav_status = "fav_status"
        case total_unfav_place = "total_unfav_place"
        case total_fav_place = "total_fav_place"
        case country_name = "country_name"
        case country_name_ar = "country_name_ar"
        case city_name = "city_name"
        case city_name_ar = "city_name_ar"
        case avg_rating = "avg_rating"
        case plan_purchase_status = "plan_purchase_status"
        case tag_details = "tag_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        placeid = try values.decodeIfPresent(String.self, forKey: .placeid)
        country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
        city_id = try values.decodeIfPresent(String.self, forKey: .city_id)
        tag_id = try values.decodeIfPresent(String.self, forKey: .tag_id)
        place_name = try values.decodeIfPresent(String.self, forKey: .place_name)
        place_name_ar = try values.decodeIfPresent(String.self, forKey: .place_name_ar)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        description_ar = try values.decodeIfPresent(String.self, forKey: .description_ar)
        tag = try values.decodeIfPresent(String.self, forKey: .tag)
        tag_ar = try values.decodeIfPresent(String.self, forKey: .tag_ar)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
        icon_background_color = try values.decodeIfPresent(String.self, forKey: .icon_background_color)
        show_only_icon = try values.decodeIfPresent(String.self, forKey: .show_only_icon)
        promo_code_and_discount = try values.decodeIfPresent(String.self, forKey: .promo_code_and_discount)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        site_url = try values.decodeIfPresent(String.self, forKey: .site_url)
        video_link_en = try values.decodeIfPresent(String.self, forKey: .video_link_en)
        video_link_ar = try values.decodeIfPresent(String.self, forKey: .video_link_ar)
        google_map_link = try values.decodeIfPresent(String.self, forKey: .google_map_link)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        fav_status = try values.decodeIfPresent(String.self, forKey: .fav_status)
        total_unfav_place = try values.decodeIfPresent(String.self, forKey: .total_unfav_place)
        total_fav_place = try values.decodeIfPresent(String.self, forKey: .total_fav_place)
        country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
        country_name_ar = try values.decodeIfPresent(String.self, forKey: .country_name_ar)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
        city_name_ar = try values.decodeIfPresent(String.self, forKey: .city_name_ar)
        avg_rating = try values.decodeIfPresent(String.self, forKey: .avg_rating)
        plan_purchase_status = try values.decodeIfPresent(String.self, forKey: .plan_purchase_status)
        tag_details = try? values.decodeIfPresent([Tag_details].self, forKey: .tag_details)
    }
}

struct Rating_review : Codable {
    let id : String?
    let user_id : String?
    let city_id : String?
    let place_id : String?
    let rating : String?
    let review : String?
    let type : String?
    let date_time : String?
    let user_name : String?
    let image : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case city_id = "city_id"
        case place_id = "place_id"
        case rating = "rating"
        case review = "review"
        case type = "type"
        case date_time = "date_time"
        case user_name = "user_name"
        case image = "image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        city_id = try values.decodeIfPresent(String.self, forKey: .city_id)
        place_id = try values.decodeIfPresent(String.self, forKey: .place_id)
        rating = try values.decodeIfPresent(String.self, forKey: .rating)
        review = try values.decodeIfPresent(String.self, forKey: .review)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        user_name = try values.decodeIfPresent(String.self, forKey: .user_name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }

}

struct Places_images : Codable {
    let id : String?
    let place_id : String?
    let image : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case place_id = "place_id"
        case image = "image"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        place_id = try values.decodeIfPresent(String.self, forKey: .place_id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}
