//
//  MessageView.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 19.04.2023.
//

import Foundation
import UIKit

protocol MessageViewDelegate: AnyObject {
    func didSendMessage(messageView: MessageView, text: String, date: Date)
}

class MessageView: UIView {
    
    // MARK: - Properties
    
    private lazy var messageInputView = InputView()
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Message>!
    weak var delegate: MessageViewDelegate?
    private var isDarkMode = false
    private let currentUserId: Int
    
    init(currentUserId: Int) {
        self.currentUserId = currentUserId
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
    
    func setup(messages: [Message]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Message>()
        snapshot.appendSections([.main])
        snapshot.appendItems(messages,  toSection: .main)
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
            cell.configure(with: item, currentUserId: currentUserId)
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

extension MessageView: InputViewDelegate {
    func didTapSendButton(inputView: InputView, text: String, date: Date) {
        delegate?.didSendMessage(messageView: self, text: text, date: Date())
    }
}

// MARK: - Constants

extension MessageView {
    enum Constants {
        enum CollectionView {
            static let padding: CGFloat = 16
        }
        static let backgroundColor = UIColor(hex: "160039")
    }
}
