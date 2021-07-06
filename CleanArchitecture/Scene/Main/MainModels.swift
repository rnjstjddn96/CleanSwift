//
//  MainModels.swift
//  CleanArchitecture
//
//  Created by imform-mm-2101 on 2021/07/06.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Main {
    // MARK: Use cases
    enum Something {
        struct Request { }
        struct Response {
            var result: TestModel?
            var error: Error?
        }
        struct ViewModel
        {
            var result: TestModel?
            var error: Error?
        }
    }
}
