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
    let conteinerView = UIView()
    
    
    struct Message: Hashable {
        let text: String
        
        init(text: String) {
            self.text = text
            
        }
    }
    
    let dataItems = [
        Message(text: "გამარჯობა"),
        Message(text: "გამარჯობა!"),
        Message(text: "როგორ ხარ?"),
        Message(text: "კარგად!"),
        
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
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            //collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
        
        let cellRegistration = UICollectionView.CellRegistration<MessageCell, Message> { (cell, indexPath, item) in
            cell.label.text = item.text
            
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
        conteinerView.layer.borderColor = UIColor(hex: "9F60FF")?.cgColor
        conteinerView.layer.borderWidth = 1.0
        conteinerView.layer.cornerRadius = 28
        
        button.setImage(UIImage(named: "send"), for: .normal)
        
        textView.backgroundColor = .clear
        //textView.layer.cornerRadius = 25
        textView.font = UIFont.systemFont(ofSize: 16)

        textView.textAlignment = .left
        textView.textColor = UIColor(hex: "191919")
        textView.text = "დაწერეთ შეტყობინება"
        
        
        addSubview(conteinerView)
        conteinerView.addSubview(textView)
        conteinerView.addSubview(button)
        
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            conteinerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            conteinerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            conteinerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            
            textView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 16),
            //textView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -15),
            textView.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: -8),
            textView.heightAnchor.constraint(equalToConstant: 44),
            textView.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 8),
            
            button.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor),
            button.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -8),
            button.topAnchor.constraint(equalTo: conteinerView.topAnchor),
            button.leadingAnchor.constraint(equalTo: textView.trailingAnchor, constant: 10)
            
            
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
