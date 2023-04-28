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
    var isDarkMode = false
    
    @objc func switchMode() {
        isDarkMode = !isDarkMode
        if isDarkMode {
            setupDark()
        } else {
            setupLight()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        senderMessageView.applySnapshot()
        receiverMessageView.applySnapshot()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
        setupSeparator()
        setupMessageViews()
        setupNavigationItems()
    }
    
    private func setupStackView() {
        stackView = UIStackView(arrangedSubviews: [senderMessageView, receiverMessageView])
        stackView.axis = .vertical
        stackView.spacing = .zero
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
    
    private func setupSeparator() {
        separator.backgroundColor = .yellow
        view.addSubview(separator)
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: senderMessageView.bottomAnchor),
            separator.bottomAnchor.constraint(equalTo: receiverMessageView.topAnchor),
            separator.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: CGFloat(Constants.separatorHeightAnchor))
        ])
    }
    
    private func setupNavigationItems() {
        modeButton.setImage(UIImage(named: "darkmode"), for: .normal)
        modeButton.addTarget(self, action: #selector(switchMode), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: modeButton)
    }
    
    private func setupMessageViews() {
        senderMessageView.setupView()
        receiverMessageView.setupView()
    }
    
    private func setupDark() {
        overrideUserInterfaceStyle = .dark
        view.backgroundColor = Constants.viewBackgroundColor
        modeButton.setImage(UIImage(named: "darkmode"), for: .normal)
        senderMessageView.setDark()
        receiverMessageView.setDark()
    }
    
    private func setupLight() {
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .white
        modeButton.setImage(UIImage(named: "lightmode"), for: .normal)
        senderMessageView.setLight()
        receiverMessageView.setLight()
    }
}

extension ChatViewController {
    enum Constants {
        static let separatorHeightAnchor = 6
        static let viewBackgroundColor = UIColor(hex: "160039")
    }
}


