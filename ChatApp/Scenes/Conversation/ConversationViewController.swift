//
//  ConversationViewController.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 18.04.2023.
//

import UIKit

class ConversationViewController: UIViewController {
    
    // MARK: - Properties
    
    private let conversationViewModel: ConversationViewModel
    private let topMessageView: ChatView
    private let bottomMessageView: ChatView
    
    private lazy var modeButtonView: ModeButtonView = {
        let modeButtonView = ModeButtonView()
        modeButtonView.addTarget(self, action: #selector(toggleSwitchMode), for: .touchUpInside)
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
    
    init(with viewModel: ConversationViewModel) {
        conversationViewModel = viewModel
        topMessageView = ChatView(viewModel: viewModel.topViewModel)
        bottomMessageView = ChatView(viewModel: viewModel.bottomViewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        topMessageView.configure(viewModel: conversationViewModel.topViewModel)
        bottomMessageView.configure(viewModel: conversationViewModel.bottomViewModel)
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
    
    @objc private func toggleSwitchMode() {
        isDarkMode.toggle()
        setupMode(isDark: isDarkMode)
    }
}

// MARK: - MessageViewDelegate

extension ConversationViewController: ChatViewDelegate {
    func didSendMessage(chatView: ChatView, text: String, date: Date, userID: Int) {
        conversationViewModel.sendMessage(text: text, date: date, userID: userID)
//        topMessageView.configure(viewModel: conversationViewModel.topViewModel)
//        bottomMessageView.configure(viewModel: conversationViewModel.bottomViewModel)
        refreshChatViews()
    }
    
    func didStartTyping(chatView: ChatView, userId: Int) {
        conversationViewModel.startTyping(userId: userId)
        refreshChatViews()
    }
    
    func didStopTyping(chatView: ChatView, userId: Int) {
        conversationViewModel.stopTyping(userId: userId)
        refreshChatViews()
    }
    
    private func refreshChatViews() {
        topMessageView.configure(viewModel: conversationViewModel.topViewModel)
        bottomMessageView.configure(viewModel: conversationViewModel.bottomViewModel)
    }
}

// MARK: - Constants

extension ConversationViewController {
    enum Constants {
        static let separatorHeightAnchor: CGFloat = 6
        static let viewBackgroundColor = UIColor(hex: "160039")
        static let modeButtonViewTrailingAnchor: CGFloat = -12
        static let stackViewTopAnchor: CGFloat = 8
    }
}
