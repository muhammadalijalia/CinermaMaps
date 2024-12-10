//
//  ScheduleTripMapName.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 14/11/24.
//

import Foundation

struct Api_ScheduleTripMapName : Codable {
    let result : [Res_ScheduleTripMapName]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([Res_ScheduleTripMapName].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_ScheduleTripMapName : Codable {
    let id : String?
    let user_id : String?
    let trip_place_id : String?
    let map_place_id : String?
    let trip_name_ar : String?
    let day_id : String?
    let day_name : String?
    let day_name_ar : String?
    let country_id : String?
    let country_name : String?
    let country_name_ar : String?
    let place_id : String?
    let trip_name : String?
    let map_type : String?
    let map_type_ar : String?
    let map_name : String?
    let table_map_name : String?
    let address : String?
    let lat : String?
    let lon : String?
    let how_much_day : String?
    let trip_by_cineramap : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case trip_place_id = "trip_place_id"
        case map_place_id = "map_place_id"
        case trip_name_ar = "trip_name_ar"
        case day_id = "day_id"
        case day_name = "day_name"
        case day_name_ar = "day_name_ar"
        case country_id = "country_id"
        case country_name = "country_name"
        case country_name_ar = "country_name_ar"
        case place_id = "place_id"
        case trip_name = "trip_name"
        case map_type = "map_type"
        case map_type_ar = "map_type_ar"
        case map_name = "map_name"
        case table_map_name = "table_map_name"
        case address = "address"
        case lat = "lat"
        case lon = "lon"
        case how_much_day = "how_much_day"
        case trip_by_cineramap = "trip_by_cineramap"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        trip_place_id = try values.decodeIfPresent(String.self, forKey: .trip_place_id)
        map_place_id = try values.decodeIfPresent(String.self, forKey: .map_place_id)
        trip_name_ar = try values.decodeIfPresent(String.self, forKey: .trip_name_ar)
        day_id = try values.decodeIfPresent(String.self, forKey: .day_id)
        day_name = try values.decodeIfPresent(String.self, forKey: .day_name)
        day_name_ar = try values.decodeIfPresent(String.self, forKey: .day_name_ar)
        country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
        country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
        country_name_ar = try values.decodeIfPresent(String.self, forKey: .country_name_ar)
        place_id = try values.decodeIfPresent(String.self, forKey: .place_id)
        trip_name = try values.decodeIfPresent(String.self, forKey: .trip_name)
        map_type = try values.decodeIfPresent(String.self, forKey: .map_type)
        map_type_ar = try values.decodeIfPresent(String.self, forKey: .map_type_ar)
        map_name = try values.decodeIfPresent(String.self, forKey: .map_name)
        table_map_name = try values.decodeIfPresent(String.self, forKey: .table_map_name)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        how_much_day = try values.decodeIfPresent(String.self, forKey: .how_much_day)
        trip_by_cineramap = try values.decodeIfPresent(String.self, forKey: .trip_by_cineramap)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}
