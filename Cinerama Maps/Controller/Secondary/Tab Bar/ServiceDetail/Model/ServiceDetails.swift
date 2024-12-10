//
//  ServiceDetails.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 05/11/24.
//

import Foundation

struct Api_ServiceDetails : Codable {
    let result : Res_ServiceDetails?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Res_ServiceDetails.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_ServiceDetails : Codable {
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
    let start_date : String?
    let end_date : String?
    let date_time : String?
    let rating_review : [Rating_review]?

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
        case start_date = "start_date"
        case end_date = "end_date"
        case date_time = "date_time"
        case rating_review = "rating_review"
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
        start_date = try values.decodeIfPresent(String.self, forKey: .start_date)
        end_date = try values.decodeIfPresent(String.self, forKey: .end_date)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        rating_review = try values.decodeIfPresent([Rating_review].self, forKey: .rating_review)
    }

}
