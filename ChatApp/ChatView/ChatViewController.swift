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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        
        
        
        view.backgroundColor = .yellow
        
        let stackView = UIStackView(arrangedSubviews: [senderMessageView, receiverMessageView])
        stackView.axis = .vertical
        stackView.spacing = 16.0
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
        
        setupStackView()
        setupNavigationItems()
        
        //senderMessageView.setupSwitchView()
    }
    
    func setupNavigationItems() {
        //        lightModeButton.setImage(UIImage(named: "lightmode"), for: .normal)
        //        lightModeButton.addTarget(self, action: #selector(lightModeButtonTapped), for: .touchUpInside)
        //        let lightModeBarButtonItem = UIBarButtonItem(customView: lightModeButton)
        //
        //        darkModeButton.setImage(UIImage(named: "darkmode"), for: .normal)
        //        darkModeButton.addTarget(self, action: #selector(darkModeButtonTapped), for: .touchUpInside)
        //        let darkModeBarButtonItem = UIBarButtonItem(customView: darkModeButton)
        //
        //        navigationItem.rightBarButtonItems = [darkModeBarButtonItem, lightModeBarButtonItem]
        
        //modeButton.setTitle("darkmode", for: .normal)
        modeButton.setImage(UIImage(named: "darkmode"), for: .normal)
        modeButton.addTarget(self, action: #selector(switchMode), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: modeButton)
        
    }
    
    //    @objc func lightModeButtonTapped() {
    //        UIScreen.main.brightness = 1.0
    //        }
    //
    //        @objc func darkModeButtonTapped() {
    //            UIScreen.main.brightness = 0.0
    //        }
    
    
    var isDarkMode = false
    
    @objc func switchMode() {
        isDarkMode = !isDarkMode
        
        if isDarkMode {
            
            overrideUserInterfaceStyle = .dark
            view.backgroundColor = .black
            modeButton.setImage(UIImage(named: "darkmode"), for: .normal)
            
        } else {
            
            overrideUserInterfaceStyle = .light
            view.backgroundColor = .white
            modeButton.setImage(UIImage(named: "nightmode"), for: .normal)
            
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


