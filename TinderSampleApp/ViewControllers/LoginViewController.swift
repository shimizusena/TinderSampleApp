//
//  LoginViewController.swift
//  TinderSampleApp
//
//  Created by 清水世那 on 2021/07/02.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let titleLabel = RegisterTitleLabel()
    private let nameTextField = RegisterTextField(placeHolderText: "名前")
    private let emailTextField = RegisterTextField(placeHolderText: "メールアドレス")
    private let passwordTextField = RegisterTextField(placeHolderText: "パスワード")
    
    private let registerButton = RegisterButton()
    
    private let alreadyHaveAccountButton = UIButton(type: .system).createAboutAccountButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    private func setupLayout() {
        passwordTextField.isSecureTextEntry = true
        view.backgroundColor = .white
        let baseStackView = UIStackView(arrangedSubviews: [nameTextField,emailTextField,passwordTextField,registerButton])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20
        view.addSubview(baseStackView)
        view.addSubview(titleLabel)
        view.addSubview(alreadyHaveAccountButton)
        
        nameTextField.anchor(height:40)
        baseStackView.anchor(left:view.leftAnchor,right: view.rightAnchor,centerY: view.centerYAnchor, leftPadding: 40,rightPadding: 40)
        titleLabel.anchor(bottom:baseStackView.topAnchor,centerX: view.centerXAnchor,bottomPadding: 20)
        alreadyHaveAccountButton.anchor(top:baseStackView.bottomAnchor,centerX: view.centerXAnchor,topPadding: 20)
    }
}
