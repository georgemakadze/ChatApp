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
    //    let elipse = UIView()
    let textDate = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("nope!")
    }
    
    func setup() {
        conteinerView.backgroundColor = UIColor(hex: "F1F1F1")
        conteinerView.layer.cornerRadius = 25
        
        textDate.textColor = UIColor(hex: "C7C7C7")
        textDate.font = UIFont.systemFont(ofSize: 12)
        
        //        elipse.backgroundColor = .gray
        //        elipse.layer.cornerRadius = 6
        
        label.backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0 // set number of lines to 0
        label.lineBreakMode = .byWordWrapping // set line break mode to .byWordWrapping
        
        //        elipse.translatesAutoresizingMaskIntoConstraints = false
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        textDate.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(conteinerView)
        contentView.addSubview(textDate)
        conteinerView.addSubview(label)
        //        conteinerView.addSubview(elipse)
        
        
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            conteinerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            conteinerView.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: 16),
            //conteinerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            label.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: -16),
            
            textDate.topAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: 4),
            textDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 36),
            //            text.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
            textDate.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
        
    }
}

