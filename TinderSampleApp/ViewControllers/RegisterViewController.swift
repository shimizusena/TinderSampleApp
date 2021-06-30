//
//  RegisterViewController.swift
//  TinderSampleApp
//
//  Created by 清水世那 on 2021/06/29.
//

import UIKit
import RxSwift
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    //MARK: - UIViews
    
    private let titleLabel = RegisterTitleLabel()
    private let nameTextField = RegisterTextField(placeHolderText: "名前")
    private let emailTextField = RegisterTextField(placeHolderText: "メールアドレス")
    private let passwordTextField = RegisterTextField(placeHolderText: "パスワード")
    
    private let registerButton = RegisterButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientLayer()
        setupLayout()
        setupBindings()
    }
    //MARK: - Methods

    private func setupGradientLayer() {
        let layer = CAGradientLayer()
        let startColor = UIColor.rgb(red: 227, green: 48, blue: 78).cgColor
        let endColor = UIColor.rgb(red: 245, green: 208, blue: 108).cgColor
        layer.colors = [startColor,endColor]
        layer.locations = [0.0,1.3]
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
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
        
        nameTextField.anchor(height:40)
        baseStackView.anchor(left:view.leftAnchor,right: view.rightAnchor,centerY: view.centerYAnchor, leftPadding: 40,rightPadding: 40)
        titleLabel.anchor(bottom:baseStackView.topAnchor,centerX: view.centerXAnchor,bottomPadding: 20)
    }
    
    private func setupBindings () {
        
        nameTextField.rx.text.asDriver()
            .drive { [weak self]text in
                
            }
            .disposed(by: disposeBag)
        
        emailTextField.rx.text.asDriver()
            .drive { [weak self]text in
                
            }
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.asDriver()
            .drive { [weak self]text in
                
            }
            .disposed(by: disposeBag)

        registerButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.createUserToFireAuth()
            }
            .disposed(by: disposeBag)
    }
    
    private func createUserToFireAuth () {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        Auth.auth().createUser(withEmail: email, password: password) { auth, error in
            if let e = error {
                print("auth情報の保存に失敗")
                return
            }
            guard let uid = auth?.user.uid else {return}
            print("uidの取得に成功",uid)
        }
    }
}
