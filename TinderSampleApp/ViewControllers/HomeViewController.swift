//
//  ViewController.swift
//  TinderSampleApp
//
//  Created by 清水世那 on 2021/06/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let topControlView = TopControlView()
        topControlView .backgroundColor = .white
        
        let view2 = UIView()
        view2.backgroundColor = .blue
        
        let bottomControlView = BottomControlView()
        
        let stackView = UIStackView(arrangedSubviews: [topControlView ,view2,bottomControlView])
        
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


}

