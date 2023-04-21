//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 18.04.2023.
//

import UIKit

class ChatViewController: UIViewController {
    
    let senderMessageView = MessageView()
    let receiverMessageView = MessageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        let stackView = UIStackView(arrangedSubviews: [senderMessageView, receiverMessageView])
        stackView.axis = .vertical
        stackView.spacing = 16.0
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
        
        setupStackView()
        
    }
    
    func setupStackView() {
        senderMessageView.setupView()
        receiverMessageView.setupView()
        
    }
}

