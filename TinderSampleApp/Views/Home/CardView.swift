//
//  CardView.swift
//  TinderSampleApp
//
//  Created by 清水世那 on 2021/06/28.
//

import UIKit

class CardView: UIView {
    
    private let gradientLayer = CAGradientLayer()
    
    //MARK: - UIViews
    private let cardImageView = CardImageView(frame: .zero)
    
    private let infoButton = UIButton(type: .system).createCardInfoButton()
    
    private let nameLabel = CardInfoLabel(text: "Andy 22", font: .systemFont(ofSize: 40, weight: .heavy))
    
    private let residenceLabel = CardInfoLabel(text: "日本　大阪府", font: .systemFont(ofSize: 20, weight: .regular))
    
    private let hobbyLabel = CardInfoLabel(text: "スマブラ、魔法使い", font: .systemFont(ofSize: 25, weight: .regular))
    
    private let introductionLabel = CardInfoLabel(text: "3Dプリンターでネズミの籠作りました", font: .systemFont(ofSize: 20, weight: .regular))
    
    private let goodLabel = CardInfoLabel(labelText: "GOOD", labelColor: .rgb(red: 137, green: 223, blue: 86))
    
    private let nopeLabel = CardInfoLabel(labelText: "NOPE", labelColor: .rgb(red: 222, green: 110, blue: 110))
    
    init(user:User) {
        super.init(frame: .zero)
        setupGradietntLayer()
        setupLayout(user:user)
        //        ターゲットはこのCardViewで動きはpanCardViewのところで書かれてる。
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panCardView))
        self.addGestureRecognizer(panGesture)
    }
    
    private func setupGradietntLayer() {
        gradientLayer.colors = [UIColor.clear,UIColor.black.cgColor]
        gradientLayer.locations = [0.5,1.1]
        cardImageView.layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.bounds
    }
    @objc private func panCardView (gesture:UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        guard let view = gesture.view else { return }
        if gesture.state == .changed {
            
            self.handlePanChange(translation: translation)
            
        } else if gesture.state == .ended {
            handlePanEnded(view:view,translation: translation)
        }
    }
    
    private func handlePanChange(translation:CGPoint) {
        let degree = translation.x / 20
        let angle = degree * .pi / 100
        let rotateTranslation = CGAffineTransform(rotationAngle: angle)
        let ratio:CGFloat = 1 / 100
        let ratioValue = ratio * translation.x
        
        if translation.x > 0 {
            self.goodLabel.alpha = ratioValue
        } else if translation.x < 0 {
            self.nopeLabel.alpha = -ratioValue
        }
        self.transform = rotateTranslation.translatedBy(x: translation.x, y: translation.y)
    }
    
    private func handlePanEnded(view:UIView,translation:CGPoint) {
        
        if translation.x <= -120 {
            view.removeCardViewAnimation(x: -600)
        } else if translation.x >= 120 {
            view.removeCardViewAnimation(x: 600)
        } else {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: []){
                self.transform = .identity
                self.layoutIfNeeded()
                self.goodLabel.alpha = 0
                self.nopeLabel.alpha = 0
            }
        }
        
    }
    private func setupLayout (user:User) {
        
        let infoVerticalStackView = UIStackView(arrangedSubviews: [residenceLabel,hobbyLabel,introductionLabel])
        infoVerticalStackView.axis = .vertical
        
        let baseStackView = UIStackView(arrangedSubviews: [infoVerticalStackView,infoButton])
        baseStackView.axis = .horizontal
        
//        Viewのはいちを作成
        addSubview(cardImageView)
        addSubview(nameLabel)
        addSubview(baseStackView)
        addSubview(goodLabel)
        addSubview(nopeLabel)
        
        cardImageView.anchor(top:topAnchor,bottom: bottomAnchor,left:leftAnchor,right: rightAnchor,leftPadding: 10,rightPadding: 10)
        baseStackView.anchor(bottom:cardImageView.bottomAnchor,left: cardImageView.leftAnchor,right: cardImageView.rightAnchor,bottomPadding: 20,leftPadding: 20,rightPadding: 20)
        infoButton.anchor(width:40)
        nameLabel.anchor(bottom:baseStackView.topAnchor,left: cardImageView.leftAnchor,bottomPadding: 10,leftPadding: 20)
        goodLabel.anchor(top:cardImageView.topAnchor,left:cardImageView.leftAnchor,width: 140,height: 55,topPadding: 25,leftPadding: 20)
        nopeLabel.anchor(top:cardImageView.topAnchor,right:cardImageView.rightAnchor,width: 140,height: 55,topPadding: 25,rightPadding: 20)
//        ユーザー情報をViewに反映
        nameLabel.text = user.name
        introductionLabel.text = user.email
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
