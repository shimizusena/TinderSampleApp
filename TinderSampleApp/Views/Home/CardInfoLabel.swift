//
//  CardInfoLabel.swift
//  TinderSampleApp
//
//  Created by 清水世那 on 2021/06/28.
//

import UIKit

class  CardInfoLabel: UILabel {
//    overrideはもともとあるものを書き換えるという意味。
//    NOPE&GOODのラベル
     init(labelText:String,labelColor:UIColor) {
        super.init(frame: .zero)
        font = .boldSystemFont(ofSize: 45)
        text = labelText
        textColor = labelColor
        layer.borderWidth = 3
        layer.borderColor = UIColor.rgb(red: 222, green: 110, blue: 110).cgColor
        layer.cornerRadius = 10
        textAlignment = .center
        alpha = 0
    }
//    その他のラベル
    init(font:UIFont) {
        super.init(frame: .zero)
        self.font = font
        self.textColor = .white
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
