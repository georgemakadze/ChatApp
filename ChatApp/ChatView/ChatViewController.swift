//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 18.04.2023.
//

import UIKit

class ChatViewController: UIViewController {
    
    let modeButton = UIButton(type: .custom)
    
    let lightModeButton = UIButton(type: .custom)
    let darkModeButton = UIButton(type: .custom)
    
    let senderMessageView = MessageView()
    let receiverMessageView = MessageView()
    let separator = UIView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        separator.backgroundColor = .yellow
        
        //view.backgroundColor = .yellow
        
        let stackView = UIStackView(arrangedSubviews: [senderMessageView, receiverMessageView])
        stackView.axis = .vertical
        stackView.spacing = 16.0 // gasasworebeli
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        view.addSubview(separator)
        
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
//            separator.heightAnchor.constraint(equalToConstant: 100),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            separator.topAnchor.constraint(equalTo: senderMessageView.bottomAnchor),
            separator.bottomAnchor.constraint(equalTo: receiverMessageView.topAnchor),
            separator.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 6)
            
        ])
        
        setupStackView()
        setupNavigationItems()
       
    }
    
    func setupNavigationItems() {
        
        modeButton.setImage(UIImage(named: "darkmode"), for: .normal)
        modeButton.addTarget(self, action: #selector(switchMode), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: modeButton)
        
    }
    
    var isDarkMode = false
    
    @objc func switchMode() {
        isDarkMode = !isDarkMode
        
        if isDarkMode {
            
            overrideUserInterfaceStyle = .dark
            view.backgroundColor = .black
            modeButton.setImage(UIImage(named: "darkmode"), for: .normal)
            view.backgroundColor = .black
            senderMessageView.setDark()
            receiverMessageView.setDark()
        } else {
            overrideUserInterfaceStyle = .light
            view.backgroundColor = .white
            modeButton.setImage(UIImage(named: "lightmode"), for: .normal)
            senderMessageView.setLight()
            receiverMessageView.setLight()
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        senderMessageView.applySnapshot()
        receiverMessageView.applySnapshot()
    }
    
    func setupStackView() {
        senderMessageView.setupView()
        receiverMessageView.setupView()
        
    }
}


