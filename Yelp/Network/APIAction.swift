//
//  APIAction.swift
//  Groow
//
//  Created by Steven Lie on 14/09/21.
//

import Foundation
import Alamofire

enum APIAction {
    case getBusinesses(limit: Int, offset: Int, sortBy: String, term: String?)
    case getBusinessDetail(id: String)
}

extension APIAction: APIRouter {
    
    var method: HTTPMethod {
        switch self {
        case .getBusinesses, .getBusinessDetail:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getBusinesses:
            return "businesses/search"
        case .getBusinessDetail(let id):
            return "businesses/\(id)"
        }
    }
    
    var actionParameters: [String: Any] {
        switch self {
        case .getBusinesses(let limit, let offset, let sortBy, let search):
            var param: [String: Any] = [
                "limit" : limit,
                "offset" : offset,
                "sort_by" : sortBy,
                "latitude": 37.441660,
                "longitude": -122.155522,
            ]
            if let search = search {
                param["term"] = search
            }
            return param
        default:
            return [:]
        }
    }
    
    var baseURL: String {
        return "https://api.yelp.com/v3/"
    }
    
    var authHeader: HTTPHeaders? {
        switch self {
        default:
            return ["Authorization": "Bearer al7VX40ugizly-QHlWWsLiUvrC0ahTAGTL6bKMVXBDlT6WO0_Upbs0JVlHy1Fh2AFVdxCD-a_Df95eqRuR_cwqhVorNVoon2ShCDJRfJxXOEQiSceE3OQbgs33LxYXYx"]
        }
    }
    
    var multipartFormData: MultipartFormData {
        let multipartFormData = MultipartFormData()
        switch self {
        default:
            ()
        }
        return multipartFormData
    }
}
