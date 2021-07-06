//
//  NetworkConfig.swift
//  MiraePay
//
//  Created by imf-mini-3 on 2021/02/23.
//

import Foundation
struct NetworkConfig {
    static let NICE_USER_URL = "http://ext.miraeassetpay.kr/namecheck/app"
    
    static let NICE_CARD_REG_WEBVIEW_URL: String = "https://m.niceepay.com:7006/epay/cardReg.do"
//    static let NICE_CARD_REG_WEBVIEW_URL: String = "https://dev.niceepay.com:7006/epay/cardReg.do"
    
    static let baseUrl = "https://ext-nice-epay.miraeassetpay.kr/"
//    static let baseUrl = "http://dev.miraeassetpay.kr/"
    
    static let ALINK_URL_STRING = "https://ext-alink-checkin-dev.miraeassetpay.kr/"
    static let API_SERVICE = "api"
    static let API_VERSION = "v2"
    static let limitDisplay = 20
    static let alinkUrl: URL = URL(string: ALINK_URL_STRING + API_SERVICE)!
    static let url: URL = URL(string: "\(baseUrl)\(API_SERVICE)")!
}

