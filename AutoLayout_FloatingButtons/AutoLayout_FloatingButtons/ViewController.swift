//
//  ViewController.swift
//  AutoLayout_FloatingButtons
//
//  Created by 정성훈 on 2021/04/17.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuButton: MenuButton = { button in
            button.translatesAutoresizingMaskIntoConstraints = false
            
            return button
        }(MenuButton())
        
        self.view.addSubview(menuButton)
        
        let safeArea = self.view.safeAreaLayoutGuide
        menuButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20).isActive = true
        menuButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20).isActive = true
    }


}

