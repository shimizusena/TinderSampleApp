//
//  ProfileImageView.swift
//  TinderSampleApp
//
//  Created by 清水世那 on 2021/07/12.
//

import UIKit

class ProfileImageView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        self.image = UIImage(named: "noImage.png")
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = 90
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
