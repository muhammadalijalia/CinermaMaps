//
//  Suggestion.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 04/11/24.
//

import Foundation

struct Api_Suggestion : Codable {
    let result : Res_Suggestion?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Res_Suggestion.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_Suggestion : Codable {
    let id : String?
    let user_id : String?
    let country_name : String?
    let description : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case country_name = "country_name"
        case description = "description"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}
