//
//  CountryMap.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 03/09/24.
//

import Foundation

struct Api_CountryMap : Codable {
    let result : [Res_CountryMap]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([Res_CountryMap].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_CountryMap : Codable {
    let id : String?
    let name : String?
    let name_ar : String?
    let country_icon : String?
    let image : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case name_ar = "name_ar"
        case country_icon = "country_icon"
        case image = "image"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        name_ar = try values.decodeIfPresent(String.self, forKey: .name_ar)
        country_icon = try values.decodeIfPresent(String.self, forKey: .country_icon)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }
}
