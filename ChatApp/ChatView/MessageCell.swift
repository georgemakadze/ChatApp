//
//  MessageCell.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 21.04.2023.
//

import Foundation
import UIKit

class MessageCell: UICollectionViewCell {
    let label = UILabel()
    let conteinerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("nope!")
    }
    
    func setup() {
        conteinerView.backgroundColor = .gray
        conteinerView.layer.cornerRadius = 25
        
        label.backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0 // set number of lines to 0
        label.lineBreakMode = .byWordWrapping // set line break mode to .byWordWrapping
        
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(conteinerView)
        conteinerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            conteinerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            conteinerView.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: 16),
            conteinerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            label.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: -16)
        ])
        
    }
}

