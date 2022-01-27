//
//  APIRouter.swift
//  Groow
//
//  Created by Steven Lie on 14/09/21.
//

import Foundation
import Alamofire

protocol APIRouter: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var actionParameters: [String: Any] { get }
    var baseURL: String { get }
    var authHeader: HTTPHeaders? { get }
    var multipartFormData: MultipartFormData { get }
}

extension APIRouter {
    func asURLRequest() throws -> URLRequest {
        let originalRequest = try URLRequest(url: baseURL.appending(path),
                                             method: method,
                                             headers: authHeader)
        
        let encodedRequest = try URLEncoding.default.encode(originalRequest,
                                                 with: actionParameters)
        
        return encodedRequest
    }
}
