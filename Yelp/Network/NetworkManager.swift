//
//  NetworkManager.swift
//  Groow
//
//  Created by Steven Lie on 14/09/21.
//

import UIKit
import Alamofire

protocol NetworkManagerProtocol {
    func request<T: Codable>(type model: T.Type,
                             succeed succeedBlock: @escaping (T) -> Void,
                             failed failedBlock: @escaping (AFError) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    var session: Session?
    var router: APIAction?
    
    init(session: Session, router: APIAction) {
        self.session = session
        self.router = router
    }
    
    func request<T: Codable>(type model: T.Type,
                    succeed succeedBlock: @escaping (T) -> Void,
                    failed failedBlock: @escaping (AFError) -> Void) {
        session?
            .request(router!, interceptor: nil)
            .validate(statusCode: 200..<501)
            .responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    do {
                        let model = try decoder.decode(model.self, from: data)
                        succeedBlock(model)
                    } catch {
                        failedBlock(AFError.createURLRequestFailed(error: error))
                    }
                case .failure(let error):
                    let message: String
                    if let httpStatusCode = response.response?.statusCode {
                        switch httpStatusCode {
                        case 400:
                            message = "error 400"
                        case 401:
                            message = "error 401"
                        case 403:
                            message = "error 403"
                        default:
                            break
                        }
                    } else {
                        message = error.localizedDescription
                        debugPrint("DEBUG: \(message)")
                    }
                    failedBlock(error)
                }
            })
    }

    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
}
