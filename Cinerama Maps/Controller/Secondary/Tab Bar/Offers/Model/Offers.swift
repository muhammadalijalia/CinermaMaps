//
//  Offers.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 05/09/24.
//

import Foundation

struct Api_AllOffers : Codable {
    let result : [Res_Offers]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([Res_Offers].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_Offers : Codable {
    let id : String?
    let category_name : String?
    let category_name_ar : String?
    let image : String?
    let status : String?
    let date_time : String?
    let company_offer : [Company_offer]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case category_name = "category_name"
        case category_name_ar = "category_name_ar"
        case image = "image"
        case status = "status"
        case date_time = "date_time"
        case company_offer = "company_offer"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        category_name = try values.decodeIfPresent(String.self, forKey: .category_name)
        category_name_ar = try values.decodeIfPresent(String.self, forKey: .category_name_ar)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        company_offer = try values.decodeIfPresent([Company_offer].self, forKey: .company_offer)
    }
}

struct Company_offer : Codable {
    let id : String?
    let country_id : String?
    let city_id : String?
    let category_id : String?
    let company_name : String?
    let company_name_ar : String?
    let description : String?
    let description_ar : String?
    let image : String?
    let discount_percentage : String?
    let discount_code : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case country_id = "country_id"
        case city_id = "city_id"
        case category_id = "category_id"
        case company_name = "company_name"
        case company_name_ar = "company_name_ar"
        case description = "description"
        case description_ar = "description_ar"
        case image = "image"
        case discount_percentage = "discount_percentage"
        case discount_code = "discount_code"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
        city_id = try values.decodeIfPresent(String.self, forKey: .city_id)
        category_id = try values.decodeIfPresent(String.self, forKey: .category_id)
        company_name = try values.decodeIfPresent(String.self, forKey: .company_name)
        company_name_ar = try values.decodeIfPresent(String.self, forKey: .company_name_ar)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        description_ar = try values.decodeIfPresent(String.self, forKey: .description_ar)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        discount_percentage = try values.decodeIfPresent(String.self, forKey: .discount_percentage)
        discount_code = try values.decodeIfPresent(String.self, forKey: .discount_code)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }
}
