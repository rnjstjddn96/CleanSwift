//
//  APIError.swift
//  MiraePay
//
//  Created by imf-mini-3 on 2021/02/23.
//

import Foundation

enum APIError: Error {
    case http(ErrorData)
    case unknown
    case notConnected
    
    var reason: String {
        switch self {
        case .http(let httpError):
            return httpError.error?.message ?? ""
        case .notConnected:
            return "인터넷 연결 후 사용해주세요"
        default:
            return "UNKNOWN"
        }
    }
}

struct ErrorData: Decodable {
    var error: ErrorCore?
}

struct ErrorCore: Decodable {
    var resultCode: Int?
    var resultMessage: String?
    var statusCode: Int?
    var message: String?
    var name: String?
}

struct APIResult<T> {
    let value: T
    let response: URLResponse
}
