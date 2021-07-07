//
//  UIView.swift
//  CleanArchitecture
//
//  Created by imform-mm-2101 on 2021/07/06.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class MainView: UIView {
    var buttonTextSubject = PublishSubject<String>()
    
    let button = UIButton.Builder()
        .withBackground(color: .black)
        .withTextColor(.white, for: .normal)
        .withFont(.systemFont(ofSize: 15))
        .withText("Get Data", for: .normal)
        .withCornerRadius(radius: 10)
        .build()
    
    func initMainView(to view: UIView) {
        view.addSubview(self)
        self.setUI()
        self.snp.makeConstraints { create in
            create.left.right.top.bottom.equalToSuperview()
        }
    }
    
    private func setUI() {
        self.addSubview(button)
        button.snp.makeConstraints { create in
            create.center.equalToSuperview()
            create.height.equalTo(70)
            create.width.equalTo(200)
        }
    }
    
}
