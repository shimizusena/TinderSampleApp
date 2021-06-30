//
//  RegisterButton.swift
//  TinderSampleApp
//
//  Created by 清水世那 on 2021/06/30.
//

import UIKit

class RegisterButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            self.backgroundColor = isHighlighted ? .rgb(red: 227, green: 48, blue: 78,alpha:0.2):
                .rgb(red: 227, green: 48, blue: 78,alpha:0.2)
            
        }
    }
    
    
    init() {
        
        super.init(frame: .zero)
        setTitle("登録", for: .normal)
        backgroundColor = .red
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}