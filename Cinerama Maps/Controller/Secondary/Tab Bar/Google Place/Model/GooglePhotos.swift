//
//  GooglePhotos.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 06/11/24.
//

import Foundation

struct Api_GooglePhotos : Codable {
    let result : [Res_GooglePhotos]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([Res_GooglePhotos].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}

struct Res_GooglePhotos : Codable {
    let place_id : String?
    let p_photo : String?

    enum CodingKeys: String, CodingKey {

        case place_id = "place_id"
        case p_photo = "p_photo"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        place_id = try values.decodeIfPresent(String.self, forKey: .place_id)
        p_photo = try values.decodeIfPresent(String.self, forKey: .p_photo)
    }

}
