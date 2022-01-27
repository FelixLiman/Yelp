//
//  API.swift
//  Groow
//
//  Created by Steven Lie on 14/09/21.
//

import Foundation

struct API<T: Codable>: Codable {
    let status: Bool?
    let messages: [String]?
    let data: T?
}
