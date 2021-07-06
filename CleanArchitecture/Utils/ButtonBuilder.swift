//
//  ButtonBuilder.swift
//  firstRX
//
//  Created by imform-mm-2101 on 2021/07/06.
//

import Foundation
import UIKit

extension UIButton {
    typealias Builder = ButtonBuilder
}

class ButtonBuilder: BuilderType {
    private var frame: CGRect = .zero
    private var title: String? = nil
    private var titleFont: UIFont? = nil
    private var titleColor: UIColor? = nil
    private var textAlignment: NSTextAlignment = .left
    private var textControlState: UIControl.State = .normal
    private var colorControlState: UIControl.State = .normal
    private var background: UIColor?
    private var radius: CGFloat = 0
    
    func withCornerRadius(radius: CGFloat) -> ButtonBuilder {
        self.radius = radius
        return self
    }
    
    func withFrame(_ frame: CGRect) -> ButtonBuilder {
        self.frame = frame
        return self
    }
    
    func withText(_ text: String?, for state: UIControl.State) -> ButtonBuilder {
        self.title = text
        self.textControlState = state
        return self
    }
    
    func withFont(_ font: UIFont?) -> ButtonBuilder {
        self.titleFont = font
        return self
    }
    
    func withTextColor(_ textColor: UIColor?, for state: UIControl.State) -> ButtonBuilder {
        self.titleColor = textColor
        self.colorControlState = state
        return self
    }
    
    func withTextAlignment(_ textAlignment: NSTextAlignment) -> ButtonBuilder {
        self.textAlignment = textAlignment
        return self
    }
    
    func withBackground(color: UIColor) -> ButtonBuilder {
        self.background = color
        return self
    }
    
    func build() -> UIButton {
        let button = UIButton(frame: .zero)
        button.setTitle(title, for: textControlState)
        button.setTitleColor(titleColor, for: colorControlState)
        button.frame = self.frame
        button.titleLabel?.font = self.titleFont
        button.titleLabel?.textAlignment = self.textAlignment
        button.backgroundColor = self.background
        button.layer.cornerRadius = self.radius
        return button
    }
}
