//
//  TextFieldBuilder.swift
//  firstRX
//
//  Created by imform-mm-2101 on 2021/07/06.
//

import Foundation
import UIKit

extension UITextField {
    typealias Builder = TextFieldBuilder
}

class TextFieldBuilder: BuilderType {
    private var frame: CGRect = .zero
    private var placeHolder: String? = nil
    private var font: UIFont? = nil
    private var textColor: UIColor? = nil
    private var textAlignment: NSTextAlignment = .left
    private var borderStyle: UITextField.BorderStyle = .roundedRect
    private var isSecure: Bool = false
    
    func withFrame(frame: CGRect) -> TextFieldBuilder {
        self.frame = frame
        return self
    }
    
    func withFont(_ font: UIFont?) -> TextFieldBuilder {
        self.font = font
        return self
    }
    
    func withTextColor(_ textColor: UIColor?) -> TextFieldBuilder {
        self.textColor = textColor
        return self
    }
    
    func withTextAlignment(_ textAlignment: NSTextAlignment) -> TextFieldBuilder {
        self.textAlignment = textAlignment
        return self
    }
    
    func withBorderStyle(style: UITextField.BorderStyle) -> TextFieldBuilder {
        self.borderStyle = style
        return self
    }
    
    func withPlaceHolder(text: String?) -> TextFieldBuilder {
        self.placeHolder = text
        return self
    }
    
    func withSecureOption() -> TextFieldBuilder {
        self.isSecure = true
        return self
    }
    
    func build() -> UITextField {
        let textField: UITextField = .init(frame: .zero)
        textField.borderStyle = self.borderStyle
        textField.textAlignment = self.textAlignment
        textField.placeholder = self.placeHolder
        textField.frame = self.frame
        textField.font = self.font
        textField.textColor = self.textColor
        textField.isSecureTextEntry = self.isSecure
        
        return textField
    }
}
