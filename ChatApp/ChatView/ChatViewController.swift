//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 18.04.2023.
//

import UIKit

class ChatViewController: UIViewController {
    
    // MARK: - Properties
    
    private let chatViewModel: ChatViewModel
    private let modeButton = UIButton(type: .custom)
    private let lightModeButton = UIButton(type: .custom)
    private let darkModeButton = UIButton(type: .custom)
    private let topMessageView = MessageView()
    private let bottomMessageView = MessageView()
    private let separator = UIView()
    private var stackView = UIStackView()
    private var isDarkMode = false
    
    // MARK: - Initilizers
    
    init(with viewModel: ChatViewModel) {
        chatViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        topMessageView.setup(messages: chatViewModel.myMessages)
        bottomMessageView.setup(messages: chatViewModel.otherMessages)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
        setupSeparator()
        setupMessageViews()
        setupNavigationItems()
    }
    
    // MARK: - SetupView
    
    private func setupStackView() {
        stackView = UIStackView(arrangedSubviews: [topMessageView, bottomMessageView])
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
            separator.topAnchor.constraint(equalTo: topMessageView.bottomAnchor),
            separator.bottomAnchor.constraint(equalTo: bottomMessageView.topAnchor),
            separator.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: CGFloat(Constants.separatorHeightAnchor))
        ])
    }
    
    private func setupNavigationItems() {
        modeButton.setImage(UIImage(named: "darkmode"), for: .normal)
        modeButton.addTarget(self, action: #selector(makeSwitchMode), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: modeButton)
    }
    
    private func setupMessageViews() {
        topMessageView.setupView()
        bottomMessageView.setupView()
        
        topMessageView.delegate = self
        bottomMessageView.delegate = self
    }
    
    func setupMode(isDark: Bool) {
        overrideUserInterfaceStyle = isDark ? .dark : .light
        view.backgroundColor = isDark ? Constants.viewBackgroundColor : .white
        isDark ? modeButton.setImage(UIImage(named: "darkmode"), for: .normal) : modeButton.setImage(UIImage(named: "lightmode"), for: .normal)
        topMessageView.setAppearance(isDark: isDark)
        bottomMessageView.setAppearance(isDark: isDark)
    }
    
    // MARK: - Dark and Light mode logic
    
    @objc private func makeSwitchMode() {
        isDarkMode.toggle()
        setupMode(isDark: isDarkMode)
    }
}

// MARK: - MessageViewDelegate

extension ChatViewController: MessageViewDelegate {
    func didSendMessage(messageView: MessageView, text: String, date: Date) {
        if messageView == topMessageView {
            chatViewModel.sendMessage(text: text, date: date, sender: .me)
        } else if messageView == bottomMessageView {
            chatViewModel.sendMessage(text: text, date: date, sender: .other)
        }
        
        topMessageView.setup(messages: chatViewModel.myMessages)
        bottomMessageView.setup(messages: chatViewModel.otherMessages)
    }
}

// MARK: - Constants

extension ChatViewController {
    enum Constants {
        static let separatorHeightAnchor = 6
        static let viewBackgroundColor = UIColor(hex: "160039")
    }
}


