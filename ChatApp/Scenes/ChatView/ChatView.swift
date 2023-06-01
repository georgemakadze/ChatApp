//
//  ChatView.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 19.04.2023.
//

import Foundation
import UIKit

protocol ChatViewDelegate: AnyObject {
    func didSendMessage(chatView: ChatView, text: String, date: Date, userID: Int)
    func didStartTyping(chatView: ChatView, userId: Int)
    func didStopTyping(chatView: ChatView, userId: Int)
}

class ChatView: UIView {
    
    // MARK: - Properties
    
    private lazy var messageInputView = InputView()
    private var viewModel: ChatViewModel
    private var collectionView: UICollectionView!
    weak var delegate: ChatViewDelegate?
    private var isDarkMode = false
    
    init(viewModel: ChatViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .white
        setupCollectionView()
        inputView()
        messageInputView.delegate = self
    }
    
    func configure(viewModel: ChatViewModel) {
        self.viewModel = viewModel
        collectionView.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: { [weak self] in
            guard let self = self else { return }
            let lastItemIndex = self.collectionView.numberOfItems(inSection: 0) - 1
            let lastIndexPath = IndexPath(item: lastItemIndex, section: 0)
            self.collectionView.scrollToItem(at: lastIndexPath, at: .top, animated: true)
        })
    }
    
    // MARK: - Make View
    
    private func setupCollectionView() {
        var layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        layoutConfig.showsSeparators = false
        layoutConfig.backgroundColor = .clear
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: listLayout)
        collectionView.backgroundColor = .clear
        collectionView.keyboardDismissMode = .onDrag
        self.addSubview(collectionView)
        
        setupCollectionViewConstraints()
        
        collectionView.dataSource = self
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: MessageCell.reuseIdentifier)
        collectionView.register(LoadingCell.self, forCellWithReuseIdentifier: LoadingCell.reuseIdentifier)
    }
    
    func inputView() {
        addSubview(messageInputView)
        messageInputView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageInputView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            messageInputView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: (Constants.CollectionView.padding)),
            messageInputView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: (-Constants.CollectionView.padding)),
            messageInputView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: (-Constants.CollectionView.padding))
        ])
    }
    
    // MARK: - CollectionView constraints
    
    private func setupCollectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: (Constants.CollectionView.padding)),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    func setAppearance(isDark: Bool) {
        backgroundColor = isDark ? Constants.backgroundColor : .white
        messageInputView.setAppearance(isDark: isDark)
        isDarkMode = isDark
        collectionView.reloadData()
    }
}

extension ChatView: InputViewDelegate {
    func didTapSendButton(inputView: InputView, text: String, date: Date) {
        delegate?.didSendMessage(chatView: self, text: text, date: Date(), userID: viewModel.userID)
    }
    
    func didStartTyping(inputView: InputView) {
        delegate?.didStartTyping(chatView: self, userId: viewModel.userID)
    }
    
    func didStopTyping(inputView: InputView) {
        delegate?.didStopTyping(chatView: self, userId: viewModel.userID)
    }
}

extension ChatView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.chatItemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if viewModel.isLoading && indexPath.item == viewModel.chatItemsCount - 1 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: LoadingCell.reuseIdentifier, for: indexPath)
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageCell.reuseIdentifier, for: indexPath) as! MessageCell
            let message = viewModel.messages[indexPath.item]
            cell.configure(with: message, isCurrentUser: viewModel.isCurrentSender(messageSenderUserID: message.userID))
            
            return cell
        }
    }
}

// MARK: - Constants

extension ChatView {
    enum Constants {
        enum CollectionView {
            static let padding: CGFloat = 16
        }
        static let backgroundColor = UIColor(hex: "160039")
    }
}
