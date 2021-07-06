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

protocol MpayService {
    var session: NetworkService { get }
}

extension MpayService {
    func test(string: String) -> AnyPublisher<APIResult<Terms>, APIError> {
        return session.request(MpayAPI.TEST(string))
            .eraseToAnyPublisher()
    }
}
