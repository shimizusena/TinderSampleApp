//
//  CardImageView.swift
//  TinderSampleApp
//
//  Created by 清水世那 on 2021/06/28.
//

import UIKit

class CardImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        layer.cornerRadius = 10
        contentMode = .scaleAspectFill
        image = UIImage(named: "Andy")
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
