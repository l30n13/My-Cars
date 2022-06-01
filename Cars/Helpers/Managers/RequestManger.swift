//
//  RequestManger.swift
//  Cars
//
//  Created by Mahbubur Rashid Leon on 1/6/22.
//

import Foundation
import Alamofire
import NotificationBannerSwift

struct RequestManager {
    enum RequestType: String, CaseIterable {
        case get    = "GET"
        case post   = "POST"
    }
    
    typealias response = ((String) -> Void)
    
    func request(using url: String,
                 params: [String : AnyObject]?,
                 type: RequestType,
                 header: HTTPHeaders? = nil,
                 success: @escaping response,
                 failure: @escaping response) {
        
        DLog("API URL: \(url)\nHeader data: \(String(describing: header))")
        NetworkManager.isReachable { (reachable) in
            if reachable {
                AF.request(url, method: HTTPMethod(rawValue: type.rawValue), parameters: params, encoding: JSONEncoding.default, headers: header).responseString(encoding: String.Encoding.utf8) { (responseString) -> Void in
                    switch responseString.response?.statusCode {
                    case 200, 201:
                        switch responseString.result {
                        case .success(let responseString):
                            success(responseString)
                        case .failure(let error):
                            failure(error.localizedDescription)
                        }
                        break
                    case 400, 401, 404, 500:
                        failure("Network problem. Please try again.")
                    default:
                        failure("Network problem. Please try again.")
                    }
                }
            } else {
                let banner = FloatingNotificationBanner(title: "No Internet!", subtitle: "Please make sure you are connected to the internet. Thank you!", titleFont: .SFUIText(.medium, size: 15), subtitleFont: .SFUIText(.regular, size: 15), style: .warning)
                banner.show()
                DLog("No Internet.")
                failure("No Internet!.")
            }
        }
    }
}
