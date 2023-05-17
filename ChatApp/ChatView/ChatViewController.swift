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
    private let topMessageView: MessageView
    private let bottomMessageView: MessageView
    
    private lazy var modeButtonView: ModeButtonView = {
        let modeButtonView = ModeButtonView()
        modeButtonView.addTarget(self, action: #selector(makeSwitchMode), for: .touchUpInside)
        modeButtonView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(modeButtonView)
        return modeButtonView
    }()
    
    private lazy var separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .yellow
        view.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topMessageView, bottomMessageView])
        stackView.axis = .vertical
        stackView.spacing = .zero
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var isDarkMode = false
    
    // MARK: - Initilizers
    
    init(with viewModel: ChatViewModel) {
        chatViewModel = viewModel
        topMessageView = MessageView(currentUserId: viewModel.topUserID)
        bottomMessageView = MessageView(currentUserId: viewModel.bottomUserID)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        topMessageView.configure(messages: chatViewModel.allMessages)
        bottomMessageView.configure(messages: chatViewModel.allMessages)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupModeButtonConstraints()
        setupStackViewConstraints()
        setupSeparatorConstraints()
        setupMessageViews()
        setupMode(isDark: false)
    }
    
    // MARK: - SetupView
    
    private func setupStackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: modeButtonView.bottomAnchor, constant: Constants.stackViewTopAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupSeparatorConstraints() {
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: topMessageView.bottomAnchor),
            separator.bottomAnchor.constraint(equalTo: bottomMessageView.topAnchor),
            separator.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: (Constants.separatorHeightAnchor))
        ])
    }
    
    private func setupModeButtonConstraints() {
        NSLayoutConstraint.activate([
            modeButtonView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            modeButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.modeButtonViewTrailingAnchor)
        ])
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
        isDark ? modeButtonView.setImage(ModeButtonView.Constants.Button.darkImage, for: .normal) : modeButtonView.setImage(ModeButtonView.Constants.Button.lightImage, for: .normal)
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
            chatViewModel.sendMessage(text: text, date: date, userID: chatViewModel.topUserID)
        } else if messageView == bottomMessageView {
            chatViewModel.sendMessage(text: text, date: date, userID: chatViewModel.bottomUserID)
        }
        
        topMessageView.configure(messages: chatViewModel.allMessages)
        bottomMessageView.configure(messages: chatViewModel.allMessages)
    }
}

// MARK: - Constants

extension ChatViewController {
    enum Constants {
        static let separatorHeightAnchor: CGFloat = 6
        static let viewBackgroundColor = UIColor(hex: "160039")
        static let modeButtonViewTrailingAnchor: CGFloat = -12
        static let stackViewTopAnchor: CGFloat = 8
    }
}
