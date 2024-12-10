//
//  DaysSelection.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 14/11/24.
//

import Foundation

struct Api_DaysSelection : Codable {
    let result : [Res_DaysSelection]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([Res_DaysSelection].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_DaysSelection : Codable {
    let id : String?
    let day_name : String?
    let day_name_ar : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case day_name = "day_name"
        case day_name_ar = "day_name_ar"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        day_name = try values.decodeIfPresent(String.self, forKey: .day_name)
        day_name_ar = try values.decodeIfPresent(String.self, forKey: .day_name_ar)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}
