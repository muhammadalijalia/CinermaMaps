//
//  Banner.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 15/11/24.
//

import Foundation

struct Api_Banner : Codable {
    let result : [Res_Banner]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([Res_Banner].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_Banner : Codable {
    let id : String?
    let image : String?
    let link : String?
    let title : String?
    let title_ar : String?
    let description : String?
    let description_ar : String?
    let cat_id : String?
    let cat_name : String?
    let start_date : String?
    let end_date : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case image = "image"
        case link = "link"
        case title = "title"
        case title_ar = "title_ar"
        case description = "description"
        case description_ar = "description_ar"
        case cat_id = "cat_id"
        case cat_name = "cat_name"
        case start_date = "start_date"
        case end_date = "end_date"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        link = try values.decodeIfPresent(String.self, forKey: .link)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        title_ar = try values.decodeIfPresent(String.self, forKey: .title_ar)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        description_ar = try values.decodeIfPresent(String.self, forKey: .description_ar)
        cat_id = try values.decodeIfPresent(String.self, forKey: .cat_id)
        cat_name = try values.decodeIfPresent(String.self, forKey: .cat_name)
        start_date = try values.decodeIfPresent(String.self, forKey: .start_date)
        end_date = try values.decodeIfPresent(String.self, forKey: .end_date)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}
