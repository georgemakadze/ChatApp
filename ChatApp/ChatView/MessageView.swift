//
//  MessageView.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 19.04.2023.
//

import Foundation
import UIKit

class MessageView: UIView {
    private let textView = UITextView()
    private let button = UIButton(type: .custom)
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Message>!
    private let containerView = UIView()
    
    enum Section {
        case main
    }
    
    func setupView() {
        backgroundColor = .white
        setupCollectionView()
        setUpContainer()
    }
    
    func setup(messages: [Message]) {
        var snapshot: NSDiffableDataSourceSnapshot<Section, Message>!
        snapshot = NSDiffableDataSourceSnapshot<Section, Message>()
        snapshot.appendSections([.main])
        snapshot.appendItems(messages,  toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func setupCollectionView() {
        var layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        layoutConfig.showsSeparators = false
        layoutConfig.backgroundColor = .clear
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: listLayout)
        collectionView.backgroundColor = .clear
        self.addSubview(collectionView)
        
        setupCollectionViewConstant()
        
        let cellRegistration = UICollectionView.CellRegistration<MessageCell, Message> { (cell, indexPath, item) in
            cell.label.text = item.text
            cell.textDate.text = item.date
            
            switch item.sender {
            case .Me:
                cell.setTrailing()
            case.Other:
                cell.setLeading()
            }
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
    
    private func setUpContainer() {
        makeContainer()
        makeButton()
        makeTextView()
        
        setupConteinerViewConstant()
        setupTextDateConstant()
        setupButtonConstant()
    }
    
    private func makeContainer() {
        containerView.backgroundColor = Constants.containerViewBackgroundColor
        containerView.layer.borderColor = Constants.conteinerViewLayerBorderColor
        containerView.layer.borderWidth = CGFloat(Constants.containerViewLayerBorderWidth)
        containerView.layer.cornerRadius = CGFloat(Constants.containerViewLayerCornerRadius)
        addSubview(containerView)
    }
    
    private func makeButton() {
        button.setImage(UIImage(named: "send"), for: .normal)
        containerView.addSubview(button)
    }
    
    private func makeTextView() {
        textView.textAlignment = .left
        textView.textColor = Constants.textViewTextColor
        textView.font = UIFont.systemFont(ofSize:CGFloat(Constants.textViewFont))
        textView.text = "დაწერეთ შეტყობინება..."
        containerView.addSubview(textView)
    }
    
    private func setupCollectionViewConstant() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(Constants.collectionViewTopAnchor)),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    private func setupConteinerViewConstant() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(Constants.containerViewLeadingAnchor)),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: CGFloat(Constants.containerViewTrailingAnchor)),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: CGFloat(Constants.containerViewBottomAnchor))
        ])
    }
    
    private func setupTextDateConstant() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: CGFloat(Constants.textViewLeadingAnchor)),
            textView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: CGFloat(Constants.textViewBottomAnchor)),
            textView.heightAnchor.constraint(equalToConstant: CGFloat(Constants.textViewHeightAnchor)),
            textView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: CGFloat(Constants.textViewTopAnchor))
        ])
    }
    
    private func setupButtonConstant() {
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: CGFloat(Constants.buttonTrailingAnchor)),
            button.topAnchor.constraint(equalTo: containerView.topAnchor),
            button.leadingAnchor.constraint(equalTo: textView.trailingAnchor, constant: CGFloat(Constants.buttonLeadingAnchor))
        ])
    }
    
    func setDark() {
        backgroundColor = Constants.backgroundColor
        containerView.backgroundColor = Constants.darkContainerViewBackgroundColor
        textView.textColor = .white
    }
    
    func setLight() {
        backgroundColor = .white
        containerView.backgroundColor = .white
        textView.textColor = .black
    }
}

extension MessageView {
    enum Constants {
        static let collectionViewTopAnchor = 16
        static let containerViewLeadingAnchor = 16
        static let containerViewTrailingAnchor = -16
        static let containerViewBottomAnchor = -16
        static let textViewLeadingAnchor = 16
        static let textViewBottomAnchor = -8
        static let textViewHeightAnchor = 44
        static let textViewTopAnchor = 8
        static let buttonTrailingAnchor = -8
        static let buttonLeadingAnchor = 10
        static let containerViewLayerBorderWidth = 1
        static let containerViewLayerCornerRadius = 28
        static let textViewFont = 16
        static let containerViewBackgroundColor = UIColor(hex: "F1F1F1")
        static let conteinerViewLayerBorderColor = UIColor(hex: "9F60FF").cgColor
        static let textViewTextColor = UIColor(hex: "C7C7C7")
        static let backgroundColor = UIColor(hex: "160039")
        static let darkContainerViewBackgroundColor = UIColor(hex: "160039")
    }
}
