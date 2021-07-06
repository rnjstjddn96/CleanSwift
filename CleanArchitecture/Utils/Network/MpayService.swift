//
//  MpayService.swift
//  MiraePay
//
//  Created by imf-mini-3 on 2021/02/23.
//

import Foundation
import Combine
import Alamofire
import UIKit

protocol APIService {
    var session: NetworkService { get }
}

extension APIService {
    func test(string: String) -> AnyPublisher<APIResult<TestModel>, APIError> {
        return session.request(API.TEST(string))
            .eraseToAnyPublisher()
    }
}
