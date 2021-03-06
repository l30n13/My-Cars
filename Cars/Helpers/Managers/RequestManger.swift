//
//  RequestManger.swift
//  Cars
//
//  Created by Mahbubur Rashid Leon on 1/6/22.
//

import Foundation
import Alamofire

struct RequestManager {
    enum RequestType: String, CaseIterable {
        case get    = "GET"
        case post   = "POST"
    }
    enum ErrorType: Error {
        case noInternet
        case networkProblem
        case errorDescription(Error)
    }
    
    typealias successResponse = ((Data) -> Void)
    typealias errorResponse = ((ErrorType) -> Void)
    
    static func request(using url: HttpURL,
                 params: [String : AnyObject]?,
                 type: RequestType,
                 header: HTTPHeaders? = nil,
                 success: @escaping successResponse,
                 failure: @escaping errorResponse) {
        
        DLog("API URL: \(url)\nHeader data: \(String(describing: header))")
        NetworkManager.isReachable { (reachable) in
            if reachable {
                AF.request(url.url, method: HTTPMethod(rawValue: type.rawValue), parameters: params, encoding: JSONEncoding.default, headers: header).responseData { (responseData) -> Void in
                    switch responseData.response?.statusCode {
                    case 200, 201:
                        switch responseData.result {
                        case .success(let responseData):
                            success(responseData)
                        case .failure(let error):
                            failure(.errorDescription(error))
                        }
                        break
                    case 400, 401, 404, 500:
                        failure(.networkProblem)
                    default:
                        failure(.networkProblem)
                    }
                }
            } else {
                DLog("No Internet.")
                failure(.noInternet)
            }
        }
    }
}

enum HttpURL: String {
    case ARTICLE_LIST           = "article/get_articles_list"
    
    private var BASE_URL: String {
        return "https://www.apphusetreach.no/application/119267/"
    }
    
    var url: String {
        switch self {
        case .ARTICLE_LIST:
            return BASE_URL + rawValue
        }
    }
}
