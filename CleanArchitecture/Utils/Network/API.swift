//
//  MpayAPI.swift
//  MiraePay
//
//  Created by imf-mini-3 on 2021/02/23.
//

import Foundation
import Alamofire

enum API {
    case TEST(_ string: String)
    
   
}

extension API: RequestBuilder {
    
    var request: DataRequest {
        let url = NetworkConfig.url.appendingPathComponent(path)
        let request: DataRequest =
            AF.request(url, method: method,
                       parameters: parameters,
                       encoding: self.method == .get ? URLEncoding.default : JSONEncoding.default,
                       headers: headers)
        return request
    }
    
    var path: String {
        switch self {
        case .TEST(let string):
            return string 
        
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .TEST(_):
            return .get
        
        }
    }
    
    var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        switch self {
        
        case .TEST:
            return headers
        }
    }
    
    var parameters: Parameters? {
        var parameters = Parameters()
        
        switch self {
        case .TEST(_):
            return nil
            
        }
    }
    
    var multipartData: Multiparts? {
        var multipartItem = [String: Data?]()

        return multipartItem
    }
}
