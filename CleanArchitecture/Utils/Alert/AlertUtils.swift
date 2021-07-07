//
//  AlertUtils.swift
//  CleanArchitecture
//
//  Created by imform-mm-2101 on 2021/07/07.
//

import Foundation
import UIKit

final class AlertUtils {
    class func displayBasicAlert(controller: UIViewController,
                                 title: String?,
                                 message: String,
                                 showCancelButton: Bool,
                                 okButtonTitle: String,
                                 cancelButtonTitle: String,
                                 okButtonCallback: (() -> Void)?,
                                 cancelButtonCallback: (() -> Void)?) {
        var titleString = ""
        if let title = title {
            titleString = title
        }
        
        let alert = UIAlertController(title: titleString, message: message, preferredStyle: .alert)
        let alertOkAction = UIAlertAction(title: okButtonTitle, style: .default) { (action) in
            if let okButtonCallback = okButtonCallback {
                okButtonCallback()
            }
        }
        
        if showCancelButton {
            let alertCancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { (action) in
                if let cancelButtonCallback = cancelButtonCallback {
                    cancelButtonCallback()
                }
            }
            
            alert.addAction(alertCancelAction)
        }
        
        alert.addAction(alertOkAction)
        controller.present(alert, animated: true, completion: nil)
    }
}
