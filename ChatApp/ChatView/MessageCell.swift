//
//  MessageCell.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 21.04.2023.
//

import Foundation
import UIKit

class MessageCell: UICollectionViewCell {
    private var leadingConstraints: [NSLayoutConstraint] = []
    private var trailingConstraints: [NSLayoutConstraint] = []
    let label = UILabel()
    let containerView = UIView()
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
        textDate.font = .systemFont(ofSize: CGFloat(Constants.textDateFontSize))
        contentView.addSubview(textDate)
    }
    
    private func makeLabel() {
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = .systemFont(ofSize: CGFloat(Constants.labelFontSize))
        label.numberOfLines = .zero
        label.lineBreakMode = .byWordWrapping
        containerView.addSubview(label)
    }
    
    private func setupContainerViewConstant() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        leadingConstraints = [
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: CGFloat(Constants.containerViewTrailingAnchor))
        ]
        trailingConstraints = [
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: CGFloat(Constants.containerViewTrailingAnchor))
        ]
    }
    
    func setTrailing() {
        NSLayoutConstraint.activate(trailingConstraints)
        NSLayoutConstraint.deactivate(leadingConstraints)
    }
    
    func setLeading() {
        NSLayoutConstraint.activate(leadingConstraints)
        NSLayoutConstraint.deactivate(trailingConstraints)
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
            textDate.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: CGFloat(Constants.textDateBottomAnchor))
        ])
        
        leadingConstraints.append(textDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CGFloat(Constants.textDateLeadingAnchor)))
        
        trailingConstraints.append(textDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: CGFloat(-Constants.textDateLeadingAnchor)))
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
        static let textDateLeadingAnchor = 8
        static let textDateBottomAnchor = -16
        static let containerViewBackgroundColor = UIColor(hex: "F1F1F1")
        static let textDateTextColor = UIColor(hex: "C7C7C7")
    }
}


