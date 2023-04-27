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
        conteinerView.layer.cornerRadius = CGFloat(Constants.conteinerViewRadius)
        
        textDate.textColor = UIColor(hex: "C7C7C7")
        textDate.font = UIFont.systemFont(ofSize: CGFloat(Constants.textdateFontSize))
        
        //        elipse.backgroundColor = .gray
        //        elipse.layer.cornerRadius = 6
        
        label.backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants.labelFontSize))
        label.numberOfLines = .zero // set number of lines to 0
        label.lineBreakMode = .byWordWrapping // set line break mode to .byWordWrapping
        
        contentView.addSubview(conteinerView)
        contentView.addSubview(textDate)
        conteinerView.addSubview(label)
        //        conteinerView.addSubview(elipse)
        
        setupConteinerViewConstant()
        setupLabelConstant()
        setupTextDateConstant()
    }
    
    func setupConteinerViewConstant() {
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            conteinerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            conteinerView.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: CGFloat(Constants.conteinerViewtrailingAnchor))
        ])
    }
    
    func setupLabelConstant() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: CGFloat(Constants.labelTopAnchor)),
            label.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: CGFloat(Constants.labelLeadingAnchor)),
            label.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: CGFloat(Constants.labelTrailingAnchor)),
            label.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: CGFloat(Constants.labelBottomAnchor))
        ])
    }
    
    func setupTextDateConstant() {
        textDate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textDate.topAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: CGFloat(Constants.textDateTopAnchor)),
            textDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CGFloat(Constants.textDateLeadingAnchor)),
            //            text.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
            textDate.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: CGFloat(Constants.textDateBottomAnchor))
        ])
    }
}

extension MessageCell {
    enum Constants {
        static let conteinerViewtrailingAnchor = 16
        static let textdateFontSize = 12
        static let conteinerViewRadius = 25
        static let labelFontSize = 16
        static let labelTopAnchor = 16
        static let labelLeadingAnchor = 16
        static let labelTrailingAnchor = -16
        static let labelBottomAnchor = -16
        static let textDateTopAnchor = 4
        static let textDateLeadingAnchor = 36
        static let textDateBottomAnchor = -16
    }
}


