//
//  CityMap.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 03/09/24.
//

import Foundation

struct Api_CityMaps : Codable {
    
    let result : [Res_CityMap]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([Res_CityMap].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_CityMap : Codable {
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
    let country_name : String?
    let country_name_ar : String?
    let avg_rating : String?
    let tag_details : [Tag_details]?
    let fav_status : String?
    let subscription_status : String?
    
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
        case country_name = "country_name"
        case country_name_ar = "country_name_ar"
        case avg_rating = "avg_rating"
        case tag_details = "tag_details"
        case fav_status = "fav_status"
        case subscription_status = "subscription_status"
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
        country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
        country_name_ar = try values.decodeIfPresent(String.self, forKey: .country_name_ar)
        avg_rating = try values.decodeIfPresent(String.self, forKey: .avg_rating)
        tag_details = try? values.decodeIfPresent([Tag_details].self, forKey: .tag_details)
        fav_status = try values.decodeIfPresent(String.self, forKey: .fav_status)
        subscription_status = try values.decodeIfPresent(String.self, forKey: .subscription_status)
    }
}

struct Tag_details : Codable {
    let id : String?
    let country_id : String?
    let city_id : String?
    let tag_name : String?
    let tag_name_ar : String?
    let color_code : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case country_id = "country_id"
        case city_id = "city_id"
        case tag_name = "tag_name"
        case tag_name_ar = "tag_name_ar"
        case color_code = "color_code"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
        city_id = try values.decodeIfPresent(String.self, forKey: .city_id)
        tag_name = try values.decodeIfPresent(String.self, forKey: .tag_name)
        tag_name_ar = try values.decodeIfPresent(String.self, forKey: .tag_name_ar)
        color_code = try values.decodeIfPresent(String.self, forKey: .color_code)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }
}
