//
//  LabelBuilder.swift
//  firstRX
//
//  Created by imform-mm-2101 on 2021/07/06.
//

import Foundation
import UIKit

extension UILabel {
    typealias Builder = LabelBuilder
}

class LabelBuilder: BuilderType {
    private var frame: CGRect = .zero
    private var text: String? = nil
    private var font: UIFont? = nil
    private var textColor: UIColor? = nil
    private var textAlignment: NSTextAlignment = .left
    
    func withFrame(_ frame: CGRect) -> LabelBuilder {
        self.frame = frame
        return self
    }
    
    func withText(_ text: String?) -> LabelBuilder {
        self.text = text
        return self
    }
    
    func withFont(_ font: UIFont?) -> LabelBuilder {
        self.font = font
        return self
    }
    
    func withTextColor(_ textColor: UIColor?) -> LabelBuilder {
        self.textColor = textColor
        return self
    }
    
    func withTextAlignment(_ textAlignment: NSTextAlignment) -> LabelBuilder {
        self.textAlignment = textAlignment
        return self
    }

    func build() -> UILabel {
        let label: UILabel = .init(frame: .zero)
        label.text = self.text
        label.font = self.font
        label.textColor = self.textColor
        label.textAlignment = self.textAlignment
        return label
    }
}
