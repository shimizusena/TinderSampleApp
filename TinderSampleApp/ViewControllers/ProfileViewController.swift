//
//  ProfileviewController.swift
//  TinderSampleApp
//
//  Created by 清水世那 on 2021/07/10.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let cellId = "cellid"
    
    let saveButton = UIButton(type: .system).createProfileTopButton(title: "保存")
    let logoutButton = UIButton(type: .system).createProfileTopButton(title: "ログアウト")
    let profileImageView = ProfileImageView()
    let nameLabel = ProfileLabel()
    let profileEditButton = UIButton(type: .system).createProfileEditButton()
    
    lazy var infoCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .brown
        cv.register(infoCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                setupLayout()
    }
    
    private func setupLayout() {
        
        nameLabel.text = "あんでぃーだよ"
        view.backgroundColor = .white

        view.addSubview(saveButton)
        view.addSubview(logoutButton)
        view.addSubview(nameLabel)
        view.addSubview(profileImageView)
        view.addSubview(profileEditButton)
        view.addSubview(infoCollectionView)
        
        
        saveButton.anchor(top: view.topAnchor, left: view.leftAnchor, topPadding: 20, leftPadding: 15)
        logoutButton.anchor(top: view.topAnchor, right: view.rightAnchor, topPadding: 20, rightPadding: 15)
        profileImageView.anchor(top: view.topAnchor, centerX: view.centerXAnchor, width: 180, height: 180, topPadding: 60)
        nameLabel.anchor(top: profileImageView.bottomAnchor, centerX: view.centerXAnchor, topPadding: 20)
        profileEditButton.anchor(top: profileImageView.topAnchor, right: profileImageView.rightAnchor, width: 60, height: 60)
        infoCollectionView.anchor(top:nameLabel.bottomAnchor,bottom:view.bottomAnchor, left: view.leftAnchor,right: view.rightAnchor,topPadding: 20)
//        infoColletionView.anchor(top: nameLabel.bottomAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, topPadding: 20)
        
    }
}

//MARK: - デリゲートメソッド

extension ProfileViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = infoCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! infoCollectionViewCell
        return cell
    }
    
}

//TODO　別のファイルに分ける
class infoCollectionViewCell: UICollectionViewCell {
    
    
    let nameLabel = ProfileLabel(title: "名前")
    let ageLabel = ProfileLabel(title: "年齢")
    let emailLabel = ProfileLabel(title: "email")
    let regidenceLabel = ProfileLabel(title: "居住地")
    let hobbyLabel = ProfileLabel(title: "趣味")
    let introductionLabel = ProfileLabel(title: "自己紹介")
    
    let nameTextField = ProfileTextField(placeholder: "名前")
    let ageTextField = ProfileTextField(placeholder: "年齢")
    let emailTextField = ProfileTextField(placeholder: "email")
    let regidenceTextField = ProfileTextField(placeholder: "居住地")
    let hobbyTextField = ProfileTextField(placeholder: "趣味")
    let introductionTextField = ProfileTextField(placeholder: "自己紹介")
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .brown
//        let view = UIView()
//        view.backgroundColor = .blue
        
        
        let views = [[nameLabel,nameTextField],[ageLabel,ageTextField],[emailLabel,emailTextField],[regidenceLabel,regidenceTextField],[hobbyLabel,hobbyTextField],[introductionLabel,introductionTextField]]
        let stackViews = views.map { (views) -> UIStackView in
            guard let label = views.first as? UILabel,
                  let textField = views.last as? UITextField else {return UIStackView()}
            
            let stackView = UIStackView(arrangedSubviews: [label,textField])
            stackView.axis = .vertical
            stackView.spacing = 5
            textField.anchor(height:50)
            return stackView
         }
        
        let baseStackView = UIStackView(arrangedSubviews: stackViews)
        baseStackView.axis = .vertical
        baseStackView.spacing = 15
        
        addSubview(baseStackView)
        nameTextField.anchor(width: UIScreen.main.bounds.width - 40, height:80)
        baseStackView.anchor(top:topAnchor,bottom : bottomAnchor, left:leftAnchor,right:rightAnchor,topPadding: 10,leftPadding: 20, rightPadding: 20)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

