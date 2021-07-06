//
//  NetworkService.swift
//  MiraePay
//
//  Created by imf-mini-3 on 2021/02/23.
//

import Foundation
import Alamofire
import Combine
import SwiftyJSON
import SwiftyBeaver

let log = SwiftyBeaver.self
protocol NetworkServiceInterface: class {
    func request<T>(_ apiBuilder: RequestBuilder, _ decoder: JSONDecoder)
                        -> AnyPublisher<APIResult<T>, APIError> where T: Decodable
    func request<T>(api: RequestBuilder, dataRequest: DataRequest, _ decoder: JSONDecoder)
                        -> AnyPublisher<APIResult<T>, APIError> where T: Decodable
}

final class NetworkService: NetworkServiceInterface {
    func request<T>(
        api: RequestBuilder,
        dataRequest: DataRequest,
        _ decoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<APIResult<T>, APIError> where T : Decodable {
        
        log.debug("""
        REQUEST:\n\(api.path)\nHEADER:\n\(api.headers)
        PARAMETER\n: \(String(describing: api.parameters))
        """)
        
        switch NSObject().currentReachabilityStatus {
        case .notReachable:
            break
        case .reachableViaWWAN:
            break
        case .reachableViaWiFi:
            break
        }
        
        return dataRequest
            .validate()
            .publishData(emptyResponseCodes: [200, 204, 205])
            .tryMap {  result -> APIResult<T> in
                if let error = result.error {
                    log.debug("RESPONSE:\n\(api.path)\n\(JSON(error))")
                    if let errorData = result.data {
                        let value = try decoder.decode(ErrorData.self, from: errorData)
                        throw APIError.http(value)
                    }
                    else {
                        throw error
                    }
                }
                if let data = result.data {
                // 응답이 성공이고 result가 있을 때
                    log.debug("RESPONSE:\n\(api.path)\nCODE:\(String(describing: result.response?.statusCode)):\n\(JSON(data))")
                    let value = try decoder.decode(T.self, from: data)
                    return APIResult(value: value, response: result.response!)
                } else {
                // 응답이 성공이고 result가 없을 때 Empty를 리턴
                    return APIResult(value: Empty.emptyValue() as! T, response: result.response!)
                }
            }
            .mapError({  (error) -> APIError in
                log.debug("RESPONSE:\n\(api.path)\n\(JSON(error))")
                if let apiError = error as? APIError {
                    return apiError
                } else {
                    return .unknown
                }
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func request<T>(_ apiBuilder: RequestBuilder, _ decoder: JSONDecoder = JSONDecoder())
                        -> AnyPublisher<APIResult<T>, APIError> where T: Decodable {
        
        switch NSObject().currentReachabilityStatus {
        case .notReachable:
            break
        case .reachableViaWWAN:
            break
        case .reachableViaWiFi:
            break
        }
        
        log.debug("""
        REQUEST:\n\(apiBuilder.path)\nHEADER:\n\(apiBuilder.headers)
        PARAMETER:\n\(String(describing: apiBuilder.parameters))
        """)
        
        return apiBuilder.request
            .validate()
            .publishData(emptyResponseCodes: [200, 201, 204, 205])
            .tryMap {  result -> APIResult<T> in
                if let error = result.error {
                    log.debug("RESPONSE:\n\(apiBuilder.path)\n\(JSON(error))")
                    if let errorData = result.data {
                        let value = try decoder.decode(ErrorData.self, from: errorData)
                        throw APIError.http(value)
                    }
                    else {
                        throw error
                    }
                }
                if let data = result.data {
                // 응답이 성공이고 result가 있을 때
                    let value = try decoder.decode(T.self, from: data)
                    log.debug("RESPONSE:\n\(apiBuilder.path)\nCODE:\(String(describing: result.response?.statusCode)):\n\(JSON(data))")
                    return APIResult(value: value, response: result.response!)
                } else {
                // 응답이 성공이고 result가 없을 때 Empty를 리턴
                    return APIResult(value: Empty.emptyValue() as! T, response: result.response!)
                }
            }
            .mapError({  (error) -> APIError in
                log.debug("RESPONSE:\n\(apiBuilder.path)\n\(JSON(error))")
                if let apiError = error as? APIError {
                    return apiError
                } else {
                    return .unknown
                }
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

