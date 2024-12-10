//
//  Services.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 05/09/24.
//

import Foundation

struct Api_Services : Codable {
    let result : [Res_Services]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([Res_Services].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct Res_Services : Codable {
    let id : String?
    let country_id : String?
    let city_id : String?
    let company_name : String?
    let company_name_ar : String?
    let description : String?
    let description_ar : String?
    let mobile : String?
    let address : String?
    let image1 : String?
    let image2 : String?
    let image3 : String?
    let discount_percentage : String?
    let discount_code : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case country_id = "country_id"
        case city_id = "city_id"
        case company_name = "company_name"
        case company_name_ar = "company_name_ar"
        case description = "description"
        case description_ar = "description_ar"
        case mobile = "mobile"
        case address = "address"
        case image1 = "image1"
        case image2 = "image2"
        case image3 = "image3"
        case discount_percentage = "discount_percentage"
        case discount_code = "discount_code"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
        city_id = try values.decodeIfPresent(String.self, forKey: .city_id)
        company_name = try values.decodeIfPresent(String.self, forKey: .company_name)
        company_name_ar = try values.decodeIfPresent(String.self, forKey: .company_name_ar)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        description_ar = try values.decodeIfPresent(String.self, forKey: .description_ar)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        image1 = try values.decodeIfPresent(String.self, forKey: .image1)
        image2 = try values.decodeIfPresent(String.self, forKey: .image2)
        image3 = try values.decodeIfPresent(String.self, forKey: .image3)
        discount_percentage = try values.decodeIfPresent(String.self, forKey: .discount_percentage)
        discount_code = try values.decodeIfPresent(String.self, forKey: .discount_code)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}
