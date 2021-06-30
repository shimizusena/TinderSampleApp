//
//  UIButton-Extension.swift
//  TinderSampleApp
//
//  Created by 清水世那 on 2021/06/28.
//

import UIKit

extension UIButton {
    func createCardInfoButton() -> UIButton {
        self.setImage(UIImage(systemName: "info.circle.fill")?.resize(size: .init(width: 40, height: 40)),for: .normal)
        self.tintColor = .white
        self.imageView?.contentMode = .scaleAspectFit
        return self
    }
    
}
