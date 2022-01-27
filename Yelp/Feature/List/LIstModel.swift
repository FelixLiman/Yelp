//
//  LIstModel.swift
//  Yelp
//
//  Created by Felix Liman on 26/01/22.
//

import Foundation

struct BusinessModel: Codable {
    let businesses: [Business]
    let total: Int
}

struct Business: Codable {
    let id: String
    let alias: String?
    let name: String?
    let imageUrl: String?
    let photos: [String]?
    let isClaimed: Bool?
    let isClosed: Bool?
    let url: String?
    let reviewCount: Int?
    let categories: [BusinessCategory]?
    let rating: Double?
    let coordinates: Coordinate?
    let transactions: [String]?
    let price: String?
    let hours: [BusinessHour]?
    let location: BusinessLocation?
    let phone: String?
    let displayPhone: String?
    let distance: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case alias
        case name
        case imageUrl = "image_url"
        case photos
        case isClaimed = "is_claimed"
        case isClosed = "is_closed"
        case url
        case reviewCount = "review_count"
        case categories
        case rating
        case coordinates
        case transactions
        case price
        case hours
        case location
        case phone
        case displayPhone = "display_phone"
        case distance
    }
}

struct BusinessLocation: Codable {
    let address1: String?
    let address2: String?
    let address3: String?
    let city: String?
    let zipCode: String?
    let country: String?
    let state: String?
    let displayAddress: [String]?

    enum CodingKeys: String, CodingKey {
        case address1
        case address2
        case address3
        case city
        case zipCode = "zip_code"
        case country
        case state
        case displayAddress = "display_address"
    }
}

struct Coordinate: Codable {
    let latitude: Double?
    let longitude: Double?
}

struct BusinessHour: Codable {
    let open: [BusinessCertainHour]?
}

struct BusinessCertainHour: Codable {
    let isOvernight: Bool?
    var start: String?
    var end: String?
    let day: Int?

    enum CodingKeys: String, CodingKey {
        case isOvernight = "is_overnight"
        case start
        case end
        case day
    }
}

struct BusinessCategory: Codable {
    let alias: String?
    let title: String?
}
