//
//  Guidlines.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 05/09/24.
//

import Foundation

struct Api_GuidelinesTips : Codable {
    let result : [Res_GuidelineTips]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([Res_GuidelineTips].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_GuidelineTips : Codable {
    let id : String?
    let country_id : String?
    let city_id : String?
    let title : String?
    let title_ar : String?
    let description : String?
    let description_ar : String?
    let image : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case country_id = "country_id"
        case city_id = "city_id"
        case title = "title"
        case title_ar = "title_ar"
        case description = "description"
        case description_ar = "description_ar"
        case image = "image"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
        city_id = try values.decodeIfPresent(String.self, forKey: .city_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        title_ar = try values.decodeIfPresent(String.self, forKey: .title_ar)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        description_ar = try values.decodeIfPresent(String.self, forKey: .description_ar)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}
