//
//  RegisterTextField.swift
//  TinderSampleApp
//
//  Created by 清水世那 on 2021/06/29.
//

import UIKit

class RegisterTextField: UITextField {
    init(placeHolderText:String) {
        super.init(frame: .zero)
        placeholder = placeHolderText
        borderStyle = .roundedRect
        font = .systemFont(ofSize: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
