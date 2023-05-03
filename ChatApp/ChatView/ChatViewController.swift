//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 18.04.2023.
//

import UIKit

class ChatViewController: UIViewController {
    private let chatViewModel = ChatViewModel()
    private let modeButton = UIButton(type: .custom)
    private let lightModeButton = UIButton(type: .custom)
    private let darkModeButton = UIButton(type: .custom)
    private let myMessageView = MessageView()
    private let otherMessageView = MessageView()
    private let separator = UIView()
    private var stackView: UIStackView!
    private var isDarkMode = false
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        myMessageView.setup(messages: chatViewModel.myMessages)
        otherMessageView.setup(messages: chatViewModel.otherMessages)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
        setupSeparator()
        setupMessageViews()
        setupNavigationItems()
    }
    
    private func setupStackView() {
        stackView = UIStackView(arrangedSubviews: [myMessageView, otherMessageView])
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
            separator.topAnchor.constraint(equalTo: myMessageView.bottomAnchor),
            separator.bottomAnchor.constraint(equalTo: otherMessageView.topAnchor),
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
        myMessageView.setupView()
        otherMessageView.setupView()
        
        myMessageView.delegate = self
        otherMessageView.delegate = self
    }
    
    private func setupDark() {
        overrideUserInterfaceStyle = .dark
        view.backgroundColor = Constants.viewBackgroundColor
        modeButton.setImage(UIImage(named: "darkmode"), for: .normal)
        myMessageView.setDark()
        otherMessageView.setDark()
    }
    
    private func setupLight() {
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .white
        modeButton.setImage(UIImage(named: "lightmode"), for: .normal)
        myMessageView.setLight()
        otherMessageView.setLight()
    }
    
    @objc private func switchMode() {
        isDarkMode.toggle()
        isDarkMode ? setupDark() : setupLight()
    }
}

extension ChatViewController: MessageViewDelegate {
    func didSendMessage(messageView: MessageView, text: String, date: Date) {
        if messageView == myMessageView {
            print("my: \(text)")
        } else if messageView == otherMessageView {
            print("other: \(text)")
        }
    }
}

extension ChatViewController {
    enum Constants {
        static let separatorHeightAnchor = 6
        static let viewBackgroundColor = UIColor(hex: "160039")
    }
}


