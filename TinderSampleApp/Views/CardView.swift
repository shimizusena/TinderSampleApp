//
//  CardView.swift
//  TinderSampleApp
//
//  Created by 清水世那 on 2021/06/28.
//

import UIKit

class CardView: UIView {
    
    
    let cardImageView:UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        iv.layer.cornerRadius = 10
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .heavy)
        label.textColor = .white
        label.text = "Taro 22"
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(cardImageView)
        addSubview(nameLabel)
        
        cardImageView.anchor(top:topAnchor,bottom: bottomAnchor,left:leftAnchor,right: rightAnchor,leftPadding: 10,rightPadding: 10)
        nameLabel.anchor(bottom:cardImageView.bottomAnchor,left: cardImageView.leftAnchor,bottomPadding: 40,leftPadding: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
