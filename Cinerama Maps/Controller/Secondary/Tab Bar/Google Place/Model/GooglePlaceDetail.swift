//
//  GooglePlaceDetail.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 06/11/24.
//

import Foundation

struct Api_GooglePlaceDetail : Codable {
    let result : Res_GooglePlaceDetail?
    let message : String?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        
        case result = "result"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Res_GooglePlaceDetail.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_GooglePlaceDetail : Codable {
    let id : String?
    let placeid : String?
    let country_id : String?
    let city_id : String?
    let tag_id : String?
    let place_name : String?
    let place_name_ar : String?
    let description : String?
    let description_ar : String?
    let tag : String?
    let tag_ar : String?
    let address : String?
    let lat : String?
    let lon : String?
    let icon : String?
    let icon_background_color : String?
    let promo_code_and_discount : String?
    let mobile : String?
    let email : String?
    let site_url : String?
    let video_link_en : String?
    let video_link_ar : String?
    let google_map_link : String?
    let date_time : String?
    let distance : String?
    let fav_status : String?
    let total_unfav_place : String?
    let total_fav_place : String?
    let country_details : Country_details?
    let city_details : City_details?
    let avg_rating : String?
    let tag_details : [Tag_details]?
    let places_images : [Places_images]?
    let rating_review : [Rating_review]?
    let google_map : Google_map?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case placeid = "placeid"
        case country_id = "country_id"
        case city_id = "city_id"
        case tag_id = "tag_id"
        case place_name = "place_name"
        case place_name_ar = "place_name_ar"
        case description = "description"
        case description_ar = "description_ar"
        case tag = "tag"
        case tag_ar = "tag_ar"
        case address = "address"
        case lat = "lat"
        case lon = "lon"
        case icon = "icon"
        case icon_background_color = "icon_background_color"
        case promo_code_and_discount = "promo_code_and_discount"
        case mobile = "mobile"
        case email = "email"
        case site_url = "site_url"
        case video_link_en = "video_link_en"
        case video_link_ar = "video_link_ar"
        case google_map_link = "google_map_link"
        case date_time = "date_time"
        case distance = "distance"
        case fav_status = "fav_status"
        case total_unfav_place = "total_unfav_place"
        case total_fav_place = "total_fav_place"
        case country_details = "country_details"
        case city_details = "city_details"
        case avg_rating = "avg_rating"
        case tag_details = "tag_details"
        case places_images = "places_images"
        case rating_review = "rating_review"
        case google_map = "google_map"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        placeid = try values.decodeIfPresent(String.self, forKey: .placeid)
        country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
        city_id = try values.decodeIfPresent(String.self, forKey: .city_id)
        tag_id = try values.decodeIfPresent(String.self, forKey: .tag_id)
        place_name = try values.decodeIfPresent(String.self, forKey: .place_name)
        place_name_ar = try values.decodeIfPresent(String.self, forKey: .place_name_ar)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        description_ar = try values.decodeIfPresent(String.self, forKey: .description_ar)
        tag = try values.decodeIfPresent(String.self, forKey: .tag)
        tag_ar = try values.decodeIfPresent(String.self, forKey: .tag_ar)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
        icon_background_color = try values.decodeIfPresent(String.self, forKey: .icon_background_color)
        promo_code_and_discount = try values.decodeIfPresent(String.self, forKey: .promo_code_and_discount)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        site_url = try values.decodeIfPresent(String.self, forKey: .site_url)
        video_link_en = try values.decodeIfPresent(String.self, forKey: .video_link_en)
        video_link_ar = try values.decodeIfPresent(String.self, forKey: .video_link_ar)
        google_map_link = try values.decodeIfPresent(String.self, forKey: .google_map_link)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        distance = try values.decodeIfPresent(String.self, forKey: .distance)
        fav_status = try values.decodeIfPresent(String.self, forKey: .fav_status)
        total_unfav_place = try values.decodeIfPresent(String.self, forKey: .total_unfav_place)
        total_fav_place = try values.decodeIfPresent(String.self, forKey: .total_fav_place)
        country_details = try values.decodeIfPresent(Country_details.self, forKey: .country_details)
        city_details = try values.decodeIfPresent(City_details.self, forKey: .city_details)
        avg_rating = try values.decodeIfPresent(String.self, forKey: .avg_rating)
        tag_details = try? values.decodeIfPresent([Tag_details].self, forKey: .tag_details)
        places_images = try values.decodeIfPresent([Places_images].self, forKey: .places_images)
        rating_review = try values.decodeIfPresent([Rating_review].self, forKey: .rating_review)
        google_map = try values.decodeIfPresent(Google_map.self, forKey: .google_map)
    }
}

struct City_details : Codable {
    let id : String?
    let country_id : String?
    let tag_id : String?
    let name : String?
    let name_ar : String?
    let about_city : String?
    let about_city_ar : String?
    let tag : String?
    let tag_ar : String?
    let image : String?
    let currency : String?
    let currency_ar : String?
    let clothing : String?
    let clothing_ar : String?
    let health : String?
    let health_ar : String?
    let communications : String?
    let communications_ar : String?
    let offical_language : String?
    let offical_language_ar : String?
    let best_time_to_visit : String?
    let best_time_to_visit_ar : String?
    let electrical_socket : String?
    let electrical_socket_ar : String?
    let the_waether : String?
    let the_waether_ar : String?
    let car_police_number : String?
    let police_number : String?
    let address : String?
    let lat : String?
    let lon : String?
    let city_map_price : String?
    let city_map_month : String?
    let date_time : String?
    let remove_status : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case country_id = "country_id"
        case tag_id = "tag_id"
        case name = "name"
        case name_ar = "name_ar"
        case about_city = "about_city"
        case about_city_ar = "about_city_ar"
        case tag = "tag"
        case tag_ar = "tag_ar"
        case image = "image"
        case currency = "currency"
        case currency_ar = "currency_ar"
        case clothing = "clothing"
        case clothing_ar = "clothing_ar"
        case health = "health"
        case health_ar = "health_ar"
        case communications = "communications"
        case communications_ar = "communications_ar"
        case offical_language = "offical_language"
        case offical_language_ar = "offical_language_ar"
        case best_time_to_visit = "best_time_to_visit"
        case best_time_to_visit_ar = "best_time_to_visit_ar"
        case electrical_socket = "electrical_socket"
        case electrical_socket_ar = "electrical_socket_ar"
        case the_waether = "the_waether"
        case the_waether_ar = "the_waether_ar"
        case car_police_number = "car_police_number"
        case police_number = "police_number"
        case address = "address"
        case lat = "lat"
        case lon = "lon"
        case city_map_price = "city_map_price"
        case city_map_month = "city_map_month"
        case date_time = "date_time"
        case remove_status = "remove_status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
        tag_id = try values.decodeIfPresent(String.self, forKey: .tag_id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        name_ar = try values.decodeIfPresent(String.self, forKey: .name_ar)
        about_city = try values.decodeIfPresent(String.self, forKey: .about_city)
        about_city_ar = try values.decodeIfPresent(String.self, forKey: .about_city_ar)
        tag = try values.decodeIfPresent(String.self, forKey: .tag)
        tag_ar = try values.decodeIfPresent(String.self, forKey: .tag_ar)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        currency_ar = try values.decodeIfPresent(String.self, forKey: .currency_ar)
        clothing = try values.decodeIfPresent(String.self, forKey: .clothing)
        clothing_ar = try values.decodeIfPresent(String.self, forKey: .clothing_ar)
        health = try values.decodeIfPresent(String.self, forKey: .health)
        health_ar = try values.decodeIfPresent(String.self, forKey: .health_ar)
        communications = try values.decodeIfPresent(String.self, forKey: .communications)
        communications_ar = try values.decodeIfPresent(String.self, forKey: .communications_ar)
        offical_language = try values.decodeIfPresent(String.self, forKey: .offical_language)
        offical_language_ar = try values.decodeIfPresent(String.self, forKey: .offical_language_ar)
        best_time_to_visit = try values.decodeIfPresent(String.self, forKey: .best_time_to_visit)
        best_time_to_visit_ar = try values.decodeIfPresent(String.self, forKey: .best_time_to_visit_ar)
        electrical_socket = try values.decodeIfPresent(String.self, forKey: .electrical_socket)
        electrical_socket_ar = try values.decodeIfPresent(String.self, forKey: .electrical_socket_ar)
        the_waether = try values.decodeIfPresent(String.self, forKey: .the_waether)
        the_waether_ar = try values.decodeIfPresent(String.self, forKey: .the_waether_ar)
        car_police_number = try values.decodeIfPresent(String.self, forKey: .car_police_number)
        police_number = try values.decodeIfPresent(String.self, forKey: .police_number)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        city_map_price = try values.decodeIfPresent(String.self, forKey: .city_map_price)
        city_map_month = try values.decodeIfPresent(String.self, forKey: .city_map_month)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        remove_status = try values.decodeIfPresent(String.self, forKey: .remove_status)
    }
}

struct Google_map : Codable {
    let html_attributions : [String]?
    let result : Res_GoogePlaceResult?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        
        case html_attributions = "html_attributions"
        case result = "result"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        html_attributions = try values.decodeIfPresent([String].self, forKey: .html_attributions)
        result = try values.decodeIfPresent(Res_GoogePlaceResult.self, forKey: .result)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_GoogePlaceResult : Codable {
    let address_components : [Address_components]?
    let adr_address : String?
    let business_status : String?
    let current_opening_hours : Current_opening_hours?
    let editorial_summary : Editorial_summary?
    let formatted_address : String?
    let formatted_phone_number : String?
    let geometry : Geometry?
    let icon : String?
    let icon_background_color : String?
    let icon_mask_base_uri : String?
    let international_phone_number : String?
    let name : String?
    let opening_hours : Opening_hours?
    let photos : [Photos]?
    let place_id : String?
    let plus_code : Plus_code?
    let rating : Double?
    let reviews : [Reviews]?
    let url : String?
    let website : String?
    
    enum CodingKeys: String, CodingKey {
        
        case address_components = "address_components"
        case adr_address = "adr_address"
        case business_status = "business_status"
        case current_opening_hours = "current_opening_hours"
        case editorial_summary = "editorial_summary"
        case formatted_address = "formatted_address"
        case formatted_phone_number = "formatted_phone_number"
        case geometry = "geometry"
        case icon = "icon"
        case icon_background_color = "icon_background_color"
        case icon_mask_base_uri = "icon_mask_base_uri"
        case international_phone_number = "international_phone_number"
        case name = "name"
        case opening_hours = "opening_hours"
        case photos = "photos"
        case place_id = "place_id"
        case plus_code = "plus_code"
        case rating = "rating"
        case reviews = "reviews"
        case url = "url"
        case website = "website"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address_components = try values.decodeIfPresent([Address_components].self, forKey: .address_components)
        adr_address = try values.decodeIfPresent(String.self, forKey: .adr_address)
        business_status = try values.decodeIfPresent(String.self, forKey: .business_status)
        current_opening_hours = try values.decodeIfPresent(Current_opening_hours.self, forKey: .current_opening_hours)
        editorial_summary = try values.decodeIfPresent(Editorial_summary.self, forKey: .editorial_summary)
        formatted_address = try values.decodeIfPresent(String.self, forKey: .formatted_address)
        formatted_phone_number = try values.decodeIfPresent(String.self, forKey: .formatted_phone_number)
        geometry = try values.decodeIfPresent(Geometry.self, forKey: .geometry)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
        icon_background_color = try values.decodeIfPresent(String.self, forKey: .icon_background_color)
        icon_mask_base_uri = try values.decodeIfPresent(String.self, forKey: .icon_mask_base_uri)
        international_phone_number = try values.decodeIfPresent(String.self, forKey: .international_phone_number)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        opening_hours = try values.decodeIfPresent(Opening_hours.self, forKey: .opening_hours)
        photos = try values.decodeIfPresent([Photos].self, forKey: .photos)
        place_id = try values.decodeIfPresent(String.self, forKey: .place_id)
        plus_code = try values.decodeIfPresent(Plus_code.self, forKey: .plus_code)
        rating = try values.decodeIfPresent(Double.self, forKey: .rating)
        reviews = try values.decodeIfPresent([Reviews].self, forKey: .reviews)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        website = try values.decodeIfPresent(String.self, forKey: .website)
    }
}

struct Address_components : Codable {
    let long_name : String?
    let short_name : String?
    let types : [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case long_name = "long_name"
        case short_name = "short_name"
        case types = "types"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        long_name = try values.decodeIfPresent(String.self, forKey: .long_name)
        short_name = try values.decodeIfPresent(String.self, forKey: .short_name)
        types = try values.decodeIfPresent([String].self, forKey: .types)
    }
}

struct Current_opening_hours : Codable {
    let open_now : Bool?
    let periods : [Periods]?
    let weekday_text : [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case open_now = "open_now"
        case periods = "periods"
        case weekday_text = "weekday_text"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        open_now = try values.decodeIfPresent(Bool.self, forKey: .open_now)
        periods = try values.decodeIfPresent([Periods].self, forKey: .periods)
        weekday_text = try values.decodeIfPresent([String].self, forKey: .weekday_text)
    }
}

struct Editorial_summary : Codable {
    let language : String?
    let overview : String?
    
    enum CodingKeys: String, CodingKey {
        
        case language = "language"
        case overview = "overview"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        language = try values.decodeIfPresent(String.self, forKey: .language)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
    }
}

struct Geometry : Codable {
    let location : Location?
    let viewport : Viewport?
    
    enum CodingKeys: String, CodingKey {
        
        case location = "location"
        case viewport = "viewport"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        location = try values.decodeIfPresent(Location.self, forKey: .location)
        viewport = try values.decodeIfPresent(Viewport.self, forKey: .viewport)
    }
}

struct Opening_hours : Codable {
    let open_now : Bool?
    let periods : [Periods]?
    let weekday_text : [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case open_now = "open_now"
        case periods = "periods"
        case weekday_text = "weekday_text"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        open_now = try values.decodeIfPresent(Bool.self, forKey: .open_now)
        periods = try values.decodeIfPresent([Periods].self, forKey: .periods)
        weekday_text = try values.decodeIfPresent([String].self, forKey: .weekday_text)
    }
}

struct Photos : Codable {
    let height : Int?
    let html_attributions : [String]?
    let photo_reference : String?
    let width : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case height = "height"
        case html_attributions = "html_attributions"
        case photo_reference = "photo_reference"
        case width = "width"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        html_attributions = try values.decodeIfPresent([String].self, forKey: .html_attributions)
        photo_reference = try values.decodeIfPresent(String.self, forKey: .photo_reference)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
    }
}

struct Plus_code : Codable {
    let compound_code : String?
    let global_code : String?
    
    enum CodingKeys: String, CodingKey {
        
        case compound_code = "compound_code"
        case global_code = "global_code"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        compound_code = try values.decodeIfPresent(String.self, forKey: .compound_code)
        global_code = try values.decodeIfPresent(String.self, forKey: .global_code)
    }
}

struct Reviews : Codable {
    let author_name : String?
    let author_url : String?
    let language : String?
    let original_language : String?
    let profile_photo_url : String?
    let rating : Int?
    let relative_time_description : String?
    let text : String?
    let time : Int?
    let translated : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case author_name = "author_name"
        case author_url = "author_url"
        case language = "language"
        case original_language = "original_language"
        case profile_photo_url = "profile_photo_url"
        case rating = "rating"
        case relative_time_description = "relative_time_description"
        case text = "text"
        case time = "time"
        case translated = "translated"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        author_name = try values.decodeIfPresent(String.self, forKey: .author_name)
        author_url = try values.decodeIfPresent(String.self, forKey: .author_url)
        language = try values.decodeIfPresent(String.self, forKey: .language)
        original_language = try values.decodeIfPresent(String.self, forKey: .original_language)
        profile_photo_url = try values.decodeIfPresent(String.self, forKey: .profile_photo_url)
        rating = try values.decodeIfPresent(Int.self, forKey: .rating)
        relative_time_description = try values.decodeIfPresent(String.self, forKey: .relative_time_description)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        time = try values.decodeIfPresent(Int.self, forKey: .time)
        translated = try values.decodeIfPresent(Bool.self, forKey: .translated)
    }
}

struct Periods : Codable {
    let close : Close?
    let open : Open?
    
    enum CodingKeys: String, CodingKey {
        
        case close = "close"
        case open = "open"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        close = try values.decodeIfPresent(Close.self, forKey: .close)
        open = try values.decodeIfPresent(Open.self, forKey: .open)
    }
}

struct Location : Codable {
    let lat : Double?
    let lng : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case lat = "lat"
        case lng = "lng"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lat = try values.decodeIfPresent(Double.self, forKey: .lat)
        lng = try values.decodeIfPresent(Double.self, forKey: .lng)
    }
}

struct Viewport : Codable {
    let northeast : Northeast?
    let southwest : Southwest?
    
    enum CodingKeys: String, CodingKey {
        
        case northeast = "northeast"
        case southwest = "southwest"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        northeast = try values.decodeIfPresent(Northeast.self, forKey: .northeast)
        southwest = try values.decodeIfPresent(Southwest.self, forKey: .southwest)
    }
}

struct Northeast : Codable {
    let lat : Double?
    let lng : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case lat = "lat"
        case lng = "lng"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lat = try values.decodeIfPresent(Double.self, forKey: .lat)
        lng = try values.decodeIfPresent(Double.self, forKey: .lng)
    }
}

struct Southwest : Codable {
    let lat : Double?
    let lng : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case lat = "lat"
        case lng = "lng"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lat = try values.decodeIfPresent(Double.self, forKey: .lat)
        lng = try values.decodeIfPresent(Double.self, forKey: .lng)
    }
}

struct Open : Codable {
    let day : Int?
    let time : String?
    
    enum CodingKeys: String, CodingKey {
        
        case day = "day"
        case time = "time"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        day = try values.decodeIfPresent(Int.self, forKey: .day)
        time = try values.decodeIfPresent(String.self, forKey: .time)
    }
}

struct Close : Codable {
    let day : Int?
    let time : String?
    
    enum CodingKeys: String, CodingKey {
        
        case day = "day"
        case time = "time"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        day = try values.decodeIfPresent(Int.self, forKey: .day)
        time = try values.decodeIfPresent(String.self, forKey: .time)
    }
}
