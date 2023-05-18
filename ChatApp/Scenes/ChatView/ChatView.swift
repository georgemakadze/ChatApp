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
}

class ChatView: UIView {
    
    // MARK: - Properties
    
    private lazy var messageInputView = InputView()
    private let viewModel: ChatViewModel
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Message>!
    weak var delegate: ChatViewDelegate?
    private var isDarkMode = false
    
    init(viewModel: ChatViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum Section {
        case main
    }
    
    func setupView() {
        backgroundColor = .white
        setupCollectionView()
        inputView()
        messageInputView.delegate = self
    }
    
    func configure(viewModel: ChatViewModel) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Message>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.messages,  toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true, completion: { [weak self] in
            guard let self = self else { return }
            let lastItemIndex = self.collectionView.numberOfItems(inSection: 0) - 1
            let lastIndexPath = IndexPath(item: lastItemIndex, section: 0)
            self.collectionView.scrollToItem(at: lastIndexPath, at: .bottom, animated: true)
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
        self.addSubview(collectionView)
        
        setupCollectionViewConstraints()
        
        let cellRegistration = UICollectionView.CellRegistration<MessageCell, Message> { [self] (cell, indexPath, item) in
            cell.configure(with: item, isCurrentUser: viewModel.isCurrentSender(messageSenderUserID: item.userID))
            cell.setAppearance(isDark: isDarkMode)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Message>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Message) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: identifier
            )
            return cell
        }
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
    
    //MARK: - CollectionView constraints
    
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
