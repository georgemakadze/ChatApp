//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 18.04.2023.
//

import UIKit

class ChatViewController: UIViewController  {
    private let modeButton = UIButton(type: .custom)
    private let lightModeButton = UIButton(type: .custom)
    private let darkModeButton = UIButton(type: .custom)
    private let senderMessageView = MessageView()
    private let receiverMessageView = MessageView()
    private let separator = UIView()
    private var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
        setupSeparator()
        setupMessageViews()
        setupNavigationItems()
    }
    
    func setupStackView() {
        stackView = UIStackView(arrangedSubviews: [senderMessageView, receiverMessageView])
        stackView.axis = .vertical
        stackView.spacing = 0 // gasasworebeli
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupSeparator() {
        separator.backgroundColor = .yellow
        view.addSubview(separator)
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: senderMessageView.bottomAnchor),
            separator.bottomAnchor.constraint(equalTo: receiverMessageView.topAnchor),
            separator.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 6)
        ])
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
            view.backgroundColor = UIColor(hex: "160039")
            modeButton.setImage(UIImage(named: "darkmode"), for: .normal)
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
    
    func setupMessageViews() {
        senderMessageView.setupView()
        receiverMessageView.setupView()
    }
}


