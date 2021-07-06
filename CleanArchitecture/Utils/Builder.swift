//
//  Builder.swift
//  firstRX
//
//  Created by imform-mm-2101 on 2021/07/06.
//

import Foundation
import UIKit

protocol BuilderType {
    associatedtype Product
    
    func build() -> Product
}
