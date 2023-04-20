//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 18.04.2023.
//

import UIKit

class ChatViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        let senderMessageView = MessageView()
        let receiverMessageView = MessageView()
        
        senderMessageView.setupView()
        receiverMessageView.setupView()
        
        let stackView = UIStackView(arrangedSubviews: [senderMessageView, receiverMessageView])
        stackView.axis = .vertical
        stackView.spacing = 16.0
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        senderMessageView.textInput()
        receiverMessageView.textInput()
        
        senderMessageView.setupButton()
        receiverMessageView.setupButton()
        
    }
}

