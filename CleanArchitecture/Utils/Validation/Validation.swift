//
//  Validation.swift
//  firstRX
//
//  Created by imform-mm-2101 on 2021/07/06.
//

import Foundation
import UIKit

enum Validation {
    case EMAIL
    case PASSWORD
    
    var regex: String {
        switch self {
        case .EMAIL:
            return "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\])|(([a-zA-Z\\-0-9]+\\.)+[a-zA-Z]{2,}))$"
        case .PASSWORD:
            return "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@.#\\$%^&*?_~]).{8,50}"
        }
    }
}

final class ValidationUtil {
    class func isValid(text: String, type: Validation) -> Bool {
        let emailValidation = NSPredicate(format: "SELF MATCHES %@", type.regex)
        return emailValidation.evaluate(with: text)
    }
}
