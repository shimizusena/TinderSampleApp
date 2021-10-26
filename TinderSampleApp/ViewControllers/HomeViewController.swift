//
//  ViewController.swift
//  TinderSampleApp
//
//  Created by 清水世那 on 2021/06/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import PKHUD
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {
    
    private var user:User?
    //    自分以外のUser情報
    
    private var isCardAnimating = false
    private var users = [User]()
    private let disposeBag = DisposeBag()
    let topControlView = TopControlView()
    let cardView = UIView() // cardView
    let bottomControlView = BottomControlView()
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.fetchUserFromFirestore(uid: uid) { user in
            if let user = user {
                self.user = user
            }
        }
        
        fetchUsers()
    }
    
    private func fetchUsers () {
        HUD.show(.progress)
        self.users = []
        Firestore.fetchUsersFromFirestore { users in
            self.users = users
            HUD.hide()
            self.users.forEach { (user) in
                let card = CardView(user: user)
                self.cardView.addSubview(card)
                card.anchor(top:self.cardView.topAnchor,bottom: self.cardView.bottomAnchor,left: self.cardView.leftAnchor,right: self.cardView.rightAnchor)
            }
            print("自分以外のユーザー情報",self.users)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser?.uid == nil {
            let registerController = RegisterViewController()
            let nav = UINavigationController(rootViewController: registerController)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }
    }
    //MARK: - Methods
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [topControlView ,cardView,bottomControlView])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        
        self.view.addSubview(stackView)
        
        [
            
            topControlView .heightAnchor.constraint(equalToConstant: 100),
            
            bottomControlView.heightAnchor.constraint(equalToConstant: 120),
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo:view.rightAnchor)]
            .forEach {$0.isActive = true}
        
    }
    
    
    private func setupBindings () {
        topControlView.profileButton.rx.tap
            .asDriver()
            .drive { [weak self] _  in
                let profile = ProfileViewController()
                profile.user = self?.user
                profile.presentationController?.delegate = self
                self?.present(profile, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        bottomControlView.reloadView.button?.rx.tap
            .asDriver()
            .drive { [weak self] _  in
                self?.fetchUsers()
            }
            .disposed(by: disposeBag)
        
        bottomControlView.nopeView.button?.rx.tap
            .asDriver()
            .drive { [weak self] _  in
                guard let self = self else {return}
                
                if !self.isCardAnimating {
                    self.isCardAnimating = true
                    self.cardView.subviews.last?.removeCardViewAnimation(x: -600, completion: {
                        self.isCardAnimating = false
                    })
                }
                
            }
            .disposed(by: disposeBag)
        
        bottomControlView.likeView.button?.rx.tap
            .asDriver()
            .drive { [weak self] _  in
                guard let self = self else {return}
                
                if !self.isCardAnimating {
                    self.isCardAnimating = true
                    self.cardView.subviews.last?.removeCardViewAnimation(x: 600, completion: {
                        self.isCardAnimating = false
                    })
                }
            }
            .disposed(by: disposeBag)
    }
}

extension HomeViewController:UIAdaptivePresentationControllerDelegate {
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        if Auth.auth().currentUser == nil {
            self.user = nil
            self.users = []
            
            let registerController = RegisterViewController()
            let nav = UINavigationController(rootViewController:registerController)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
}

