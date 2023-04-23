//
//  MessageView.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 19.04.2023.
//

import Foundation
import UIKit

class MessageView: UIView, UITextViewDelegate, UICollectionViewDelegate {
    private let textView = UITextField()
    private let button = UIButton(type: .custom)
    //private let modeButton = UIButton(type: .custom)
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Message>!
    
    //    let switchButton = UIButton(type: .custom)
    //    let onButton = UIButton(type: .custom)
    
    //var isOn = false
    
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
        setupButton()
        //setupModeButton()
        //setupSwitchView()
        textInput()
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
    
    func setupButton() {
        
        button.setImage(UIImage(named: "send"), for: .normal)
        
        let buttonSize = CGSize(width: 40, height: 40)
        button.frame = CGRect(origin: CGPoint.zero, size: buttonSize)
        
        let buttonView = UIView(frame: button.frame)
        buttonView.addSubview(button)
        buttonView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: buttonSize.width + 16, height: buttonSize.height))
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 40))
        
        textView.rightView = buttonView
        textView.rightViewMode = .always
        textView.leftView = leftView
        textView.leftViewMode = .always
    }
    
    //    func setupModeButton() {
    //
    //        modeButton.setImage(UIImage(named: "mode"), for: .normal)
    //
    //        let buttonSize = CGSize(width: 60, height: 60)
    //        modeButton.frame = CGRect(origin: CGPoint.zero, size: buttonSize)
    //
    //        let buttonView = UIView(frame: modeButton.frame)
    //        buttonView.addSubview(modeButton)
    //        buttonView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: buttonSize.width + 16, height: buttonSize.height))
    
    //let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 60))
    
    //        textView.rightView = buttonView
    //        textView.rightViewMode = .always
    //        textView.leftView = leftView
    //        textView.leftViewMode = .always
    //   }
    
    
    //     func setupSwitchView() {
    //           switchButton.setImage(UIImage(named: "nightmode"), for: .normal)
    //           switchButton.addTarget(self, action: #selector(switchMode), for: .touchUpInside)
    //           addSubview(switchButton)
    //           switchButton.translatesAutoresizingMaskIntoConstraints = false
    //           NSLayoutConstraint.activate([
    //            switchButton.topAnchor.constraint(equalTo: self.topAnchor),
    //            switchButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
    //            switchButton.widthAnchor.constraint(equalToConstant: 60),
    //            switchButton.heightAnchor.constraint(equalToConstant: 60)
    //           ])
    //
    //         onButton.setImage(UIImage(named: "darkmode"), for: .normal)
    //         onButton.addTarget(self, action: #selector(switchMode), for: .touchUpInside)
    //         addSubview(onButton)
    //         onButton.translatesAutoresizingMaskIntoConstraints = false
    //         NSLayoutConstraint.activate([
    //          onButton.topAnchor.constraint(equalTo: self.topAnchor),
    //          onButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
    //          onButton.widthAnchor.constraint(equalToConstant: 60),
    //          onButton.heightAnchor.constraint(equalToConstant: 60)
    //         ])
    //
    
    
    
    
    //       }
    //    @objc func switchMode() {
    //            isOn.toggle()
    //            // Switch to dark mode or light mode
    //        }
    //
    
    
    
    func textInput() {
        
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = .black
        textView.textAlignment = .left
        textView.backgroundColor = .white
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.systemPink.cgColor
        textView.layer.cornerRadius = 25
        self.addSubview(textView)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            textView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15),
            textView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16)
        ])
    }
}
