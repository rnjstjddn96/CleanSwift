//
//  TestModel.swift
//  CleanArchitecture
//
//  Created by imform-mm-2101 on 2021/07/06.
//

import Foundation
import UIKit

struct TestModel: Decodable {
    var userId: Int?
    var id: Int?
    var title: String?
    var isDone: Bool?
    
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case id = "id"
        case title = "title"
        case isDone = "completed"
    }
}
