//
//  MessageView.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 19.04.2023.
//

import Foundation
import UIKit

class MessageView: UIView, UITextViewDelegate, UICollectionViewDelegate {
    private let textView = UITextView() // texfield
    private let button = UIButton(type: .custom)
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Message>!
    private let conteinerView = UIView()
    
    struct Message: Hashable {
        let text: String
        let date: String
        
        init(text: String, date: String) {
            self.text = text
            self.date = date
        }
    }
    
    let dataItems = [
        Message(text: "გამარჯობა, ზეზვა როგორ ხარ?", date: "მარ 14,16:00"),
        Message(text: "გამარჯობა, მზია როგორ ხარ?", date: "მარ 14,16:05"),
        Message(text: "კარგად!", date: "მარ 14,16:10"),
        Message(text: "ნუ მატყუებ!", date: "მარ 14,16:11")
    ]
    
    enum Section {
        case main
    }
    
    func setupView() {
        backgroundColor = .white
        setupCollectionView()
        setupConeiner()
    }
    
    func setupCollectionView() {
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
            
            //            let isMessageFromCurrentUser = item.text == "current_user_id"
            //
            //
            //                cell.label.leadingAnchor.constraint(equalTo: isMessageFromCurrentUser ? cell.contentView.leadingAnchor : cell.contentView.centerXAnchor, constant: 16).isActive = true
            //                cell.label.trailingAnchor.constraint(equalTo: isMessageFromCurrentUser ? cell.contentView.centerXAnchor : cell.contentView.trailingAnchor, constant: -16).isActive = true
            
            
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
    
    func applySnapshot() {
        var snapshot: NSDiffableDataSourceSnapshot<Section, Message>!
        snapshot = NSDiffableDataSourceSnapshot<Section, Message>()
        snapshot.appendSections([.main])
        snapshot.appendItems(dataItems, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func setupConeiner() {
        conteinerView.backgroundColor = UIColor(hex: "F1F1F1")
        conteinerView.layer.borderColor = UIColor(hex: "9F60FF").cgColor
        conteinerView.layer.borderWidth = CGFloat(Constants.conteinerViewLayerBorderWidth)
        conteinerView.layer.cornerRadius = CGFloat(Constants.conteinerViewLayerCornerRadius)
        
        button.setImage(UIImage(named: "send"), for: .normal)
        
        textView.backgroundColor = .clear
        textView.font = UIFont.systemFont(ofSize: CGFloat(Constants.textViewFont))
        
        textView.textAlignment = .left
        textView.textColor = UIColor(hex: "C7C7C7")
        textView.text = "დაწერეთ შეტყობინება..."
        
        addSubview(conteinerView)
        conteinerView.addSubview(textView)
        conteinerView.addSubview(button)
        
        setupConteinerViewConstant()
        setupTextDateConstant()
        setupButtonConstant()
    }
    
    func setupCollectionViewConstant() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(Constants.collectionViewTopAnchor)),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            //collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
    
    func setupConteinerViewConstant() {
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            conteinerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(Constants.conteinerViewLeadingAnchor)),
            conteinerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: CGFloat(Constants.conteinerViewLrailingAnchor)),
            conteinerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: CGFloat(Constants.conteinerViewBottomAnchor))
        ])
    }
    
    func setupTextDateConstant() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: CGFloat(Constants.textViewLeadingAnchor)),
            //textView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -15),
            textView.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: CGFloat(Constants.textViewBottomAnchor)),
            textView.heightAnchor.constraint(equalToConstant: CGFloat(Constants.textViewHeightAnchor)),
            textView.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: CGFloat(Constants.textViewTopAnchor))
        ])
    }
    
    func setupButtonConstant() {
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor),
            button.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: CGFloat(Constants.buttonTrailingAnchor)),
            button.topAnchor.constraint(equalTo: conteinerView.topAnchor),
            button.leadingAnchor.constraint(equalTo: textView.trailingAnchor, constant: CGFloat(Constants.buttonLeadingAnchor))
        ])
    }
    
    func setDark() {
        backgroundColor = UIColor(hex: "160039")
        conteinerView.backgroundColor = UIColor(hex: "160039")
        textView.textColor = .white
    }
    
    func setLight() {
        backgroundColor = UIColor(hex: "FFFFFF")
        conteinerView.backgroundColor = UIColor(hex: "FFFFFF")
        textView.textColor = .black
    }
}

extension MessageView {
    enum Constants {
        static let collectionViewTopAnchor = 16
        static let conteinerViewLeadingAnchor = 16
        static let conteinerViewLrailingAnchor = -16
        static let conteinerViewBottomAnchor = -16
        static let textViewLeadingAnchor = 16
        static let textViewBottomAnchor = -8
        static let textViewHeightAnchor = 44
        static let textViewTopAnchor = 8
        static let buttonTrailingAnchor = -8
        static let buttonLeadingAnchor = 10
        static let conteinerViewLayerBorderWidth = 1
        static let conteinerViewLayerCornerRadius = 28
        static let textViewFont = 16
    }
}
