//
//  BottomControlView.swift
//  TinderSampleApp
//
//  Created by 清水世那 on 2021/06/23.
//

import UIKit

//一画面を三つに分けたうちの一番下の画面
class BottomControlView: UIView {
    
    let reloadView = BottomButtonView(frame: .zero, width: 50, imageName: "Uターン矢印 2")
    let nopeView = BottomButtonView(frame: .zero, width: 60, imageName: "やや太いバツのアイコン")
    let superLikeView = BottomButtonView(frame: .zero, width: 50, imageName: "無料で使えるスターアイコン")
    let likeView = BottomButtonView(frame: .zero, width: 60, imageName: "でっぷりハートアイコン")
    let boostView = BottomButtonView(frame: .zero, width: 50, imageName: "電気のアイコン")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let baseStackView = UIStackView(arrangedSubviews: [reloadView,nopeView,superLikeView,likeView,boostView])
        
        baseStackView.axis = .horizontal
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 10
        baseStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(baseStackView)
        
        [baseStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
         baseStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
         baseStackView.leftAnchor.constraint(equalTo: leftAnchor,constant: 10),
         baseStackView.rightAnchor.constraint(equalTo:rightAnchor,constant: -10),]
            .forEach {$0?.isActive = true}
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class BottomButtonView: UIView {
    
    var button:BottomButton?
    
    init(frame: CGRect, width:CGFloat, imageName : String) {
        super.init(frame: frame)
        
        button = BottomButton(type: .custom)
        button?.setImage(UIImage(named: imageName)?.resize(size: .init(width: width * 0.5, height: width * 0.5)), for: .normal)
        //        button?.setTitle("tap", for: .normal)
        button?.translatesAutoresizingMaskIntoConstraints = false
        button?.backgroundColor = .white
        button?.layer.cornerRadius = width / 2
        
        button?.layer.shadowOffset = .init(width: 1.5, height: 2)
        button?.layer.shadowColor = UIColor.black.cgColor
        button?.layer.shadowOpacity = 0.3
        button?.layer.shadowRadius = 15
        addSubview(button!)
        
        [button?.centerYAnchor.constraint(equalTo: centerYAnchor),
         button?.centerXAnchor.constraint(equalTo: centerXAnchor),
         button?.widthAnchor.constraint(equalToConstant: width),
         button?.heightAnchor.constraint(equalToConstant: width)
        ] .forEach {$0?.isActive = true}
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BottomButton:UIButton {
    
    //    overrideとは親の関数にアクセスして変更を加えることができる。
    override var isHighlighted: Bool {
        //        didSet 上記の変数に変更が加えられたら呼び出される。
        didSet {
            if isHighlighted {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: []) {
                    self.transform = .init(scaleX: 0.8, y: 0.8)
                    self.layoutIfNeeded()
                }
            } else {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: []) {
                    self.transform = .identity
                    self.layoutIfNeeded()
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
