//
//  GeneratePlaceId.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 06/11/24.
//

import Foundation

struct Api_GenerateGMPI : Codable {
    let result : Res_GenerateGMPI?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Res_GenerateGMPI.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_GenerateGMPI : Codable {
    let place_id : String?

    enum CodingKeys: String, CodingKey {
        case place_id = "place_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        place_id = try values.decodeIfPresent(String.self, forKey: .place_id)
    }

}
