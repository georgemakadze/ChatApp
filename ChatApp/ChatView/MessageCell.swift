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
    let containerView = UIView()
    //    let elipse = UIView()
    let textDate = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("nope!")
    }
    
    private func setup() {
        contentView.backgroundColor = .clear
        
        makeContainer()
        makeLabel()
        makeTextDate()
        
        setupContainerViewConstant()
        setupLabelConstant()
        setupTextDateConstant()
    }
    
    private func makeContainer() {
        containerView.backgroundColor = Constants.containerViewBackgroundColor
        containerView.layer.cornerRadius = CGFloat(Constants.containerViewRadius)
        contentView.addSubview(containerView)
    }
    
    private func makeTextDate() {
        textDate.textColor = Constants.textDateTextColor
        textDate.font = UIFont.systemFont(ofSize: CGFloat(Constants.textDateFontSize))
        contentView.addSubview(textDate)
    }
    
    private func makeLabel() {
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants.labelFontSize))
        label.numberOfLines = .zero
        label.lineBreakMode = .byWordWrapping
        containerView.addSubview(label)
    }
    
    private func setupContainerViewConstant() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: CGFloat(Constants.containerViewTrailingAnchor))
        ])
    }
    
    private func setupLabelConstant() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: CGFloat(Constants.labelTopAnchor)),
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: CGFloat(Constants.labelLeadingAnchor)),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: CGFloat(Constants.labelTrailingAnchor)),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: CGFloat(Constants.labelBottomAnchor))
        ])
    }
    
    private func setupTextDateConstant() {
        textDate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textDate.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: CGFloat(Constants.textDateTopAnchor)),
            textDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CGFloat(Constants.textDateLeadingAnchor)),
            textDate.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: CGFloat(Constants.textDateBottomAnchor))
        ])
    }
}

extension MessageCell {
    enum Constants {
        static let containerViewTrailingAnchor = 16
        static let textDateFontSize = 12
        static let containerViewRadius = 25
        static let labelFontSize = 16
        static let labelTopAnchor = 16
        static let labelLeadingAnchor = 16
        static let labelTrailingAnchor = -16
        static let labelBottomAnchor = -16
        static let textDateTopAnchor = 4
        static let textDateLeadingAnchor = 36
        static let textDateBottomAnchor = -16
        static let containerViewBackgroundColor = UIColor(hex: "F1F1F1")
        static let textDateTextColor = UIColor(hex: "C7C7C7")
    }
}


