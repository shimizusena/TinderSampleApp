//
//  ProfileLabel.swift
//  TinderSampleApp
//
//  Created by 清水世那 on 2021/07/12.
//

import UIKit

class ProfileLabel: UILabel {
    init() {
        super.init(frame: .zero)
        self.textColor = .black
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
