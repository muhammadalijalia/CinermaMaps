//
//  Rating.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 05/11/24.
//

import Foundation

struct Api_ServiceRating : Codable {
    let result : Res_ServiceRating?
    let message : String?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        
        case result = "result"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Res_ServiceRating.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
    
}

struct Res_ServiceRating : Codable {
    let id : String?
    let user_id : String?
    let city_id : String?
    let place_id : String?
    let rating : String?
    let review : String?
    let type : String?
    let date_time : String?
    let user_name : String?
    let image : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case user_id = "user_id"
        case city_id = "city_id"
        case place_id = "place_id"
        case rating = "rating"
        case review = "review"
        case type = "type"
        case date_time = "date_time"
        case user_name = "user_name"
        case image = "image"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        city_id = try values.decodeIfPresent(String.self, forKey: .city_id)
        place_id = try values.decodeIfPresent(String.self, forKey: .place_id)
        rating = try values.decodeIfPresent(String.self, forKey: .rating)
        review = try values.decodeIfPresent(String.self, forKey: .review)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        user_name = try values.decodeIfPresent(String.self, forKey: .user_name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }
    
}
