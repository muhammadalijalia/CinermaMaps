//
//  PurchasePlan.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 16/11/24.
//

import Foundation

struct Api_PurchasePlan : Codable {
    let result : Res_PurchasePlan?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Res_PurchasePlan.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_PurchasePlan : Codable {
    let id : String?
    let user_id : String?
    let plan_id : String?
    let map_country_id : String?
    let map_city_id : String?
    let transaction_id : String?
    let amount : String?
    let type : String?
    let status : String?
    let exp_date : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case plan_id = "plan_id"
        case map_country_id = "map_country_id"
        case map_city_id = "map_city_id"
        case transaction_id = "transaction_id"
        case amount = "amount"
        case type = "type"
        case status = "status"
        case exp_date = "exp_date"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        plan_id = try values.decodeIfPresent(String.self, forKey: .plan_id)
        map_country_id = try values.decodeIfPresent(String.self, forKey: .map_country_id)
        map_city_id = try values.decodeIfPresent(String.self, forKey: .map_city_id)
        transaction_id = try values.decodeIfPresent(String.self, forKey: .transaction_id)
        amount = try values.decodeIfPresent(String.self, forKey: .amount)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        exp_date = try values.decodeIfPresent(String.self, forKey: .exp_date)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}
