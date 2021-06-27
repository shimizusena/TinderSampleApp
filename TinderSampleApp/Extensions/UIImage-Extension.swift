//
//  UIImage-Extension.swift
//  TinderSampleApp
//
//  Created by 清水世那 on 2021/06/24.
//

import UIKit

extension UIImage {
    
    func resize(size _size: CGSize) -> UIImage? {
            let widthRatio = _size.width / size.width
            let heightRatio = _size.height / size.height
            let ratio = widthRatio < heightRatio ? widthRatio : heightRatio
            
            let resizeSize = CGSize(width: size.width * ratio, height: size.height * ratio)
            
            UIGraphicsBeginImageContextWithOptions(resizeSize, false, 0.0)
            draw(in: CGRect(origin: .zero, size: resizeSize))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return resizedImage
        }
}
