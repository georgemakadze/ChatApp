//
//  MessageCell.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 21.04.2023.
//

import Foundation
import UIKit

class MessageCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private var leadingConstraints: [NSLayoutConstraint] = []
    private var trailingConstraints: [NSLayoutConstraint] = []
    private let label = UILabel()
    private lazy var containerView = UIView()
    private let textDate = UILabel()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("error!")
    }
    
    func configure(with item: Message) {
        label.text = item.text
        textDate.text = item.date
        item.sender == .me ? setBubblePosition(isTrailing: true) : setBubblePosition(isTrailing: false)
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
    
    // MARK: - Make View
    
    private func makeContainer() {
        containerView.backgroundColor = Constants.Container.containerViewBackgroundColor
        containerView.layer.cornerRadius = (Constants.Container.containerViewRadius)
        contentView.addSubview(containerView)
    }
    
    private func makeTextDate() {
        textDate.textColor = Constants.TextDate.textDateTextColor
        textDate.font = .systemFont(ofSize: (Constants.TextDate.textDateFontSize))
        contentView.addSubview(textDate)
    }
    
    private func makeLabel() {
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = .systemFont(ofSize: (Constants.Label.labelFontSize))
        label.numberOfLines = .zero
        label.lineBreakMode = .byWordWrapping
        containerView.addSubview(label)
    }
    
    // MARK: - Constraints
    
    private func setupContainerViewConstant() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        leadingConstraints = [
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: (-Constants.Container.containerViewTrailingAnchor))
        ]
        trailingConstraints = [
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: (Constants.Container.containerViewTrailingAnchor))
        ]
    }
    
    private func setBubblePosition(isTrailing: Bool) {
        if isTrailing {
            NSLayoutConstraint.activate(trailingConstraints)
            NSLayoutConstraint.deactivate(leadingConstraints)
        } else {
            NSLayoutConstraint.activate(leadingConstraints)
            NSLayoutConstraint.deactivate(trailingConstraints)
        }
        
    }
    
    private func setupLabelConstant() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: (Constants.Label.labelTopAnchor)),
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: (Constants.Label.labelLeadingAnchor)),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: (Constants.Label.labelTrailingAnchor)),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: (Constants.Label.labelBottomAnchor))
        ])
    }
    
    private func setupTextDateConstant() {
        textDate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textDate.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: (Constants.TextDate.textDateTopAnchor)),
            textDate.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: (Constants.TextDate.textDateBottomAnchor))
        ])
        
        leadingConstraints.append(textDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: (Constants.TextDate.textDateLeadingAnchor)))
        
        trailingConstraints.append(textDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: CGFloat(-Constants.TextDate.textDateLeadingAnchor)))
    }
}

// MARK: - Constants

extension MessageCell {
    enum Constants {
        enum Container {
            static let containerViewTrailingAnchor: CGFloat = 16
            static let containerViewRadius: CGFloat = 25
            static let containerViewBackgroundColor = UIColor(hex: "F1F1F1")
            
        }
        enum TextDate {
            static let textDateFontSize: CGFloat = 12
            static let textDateTopAnchor: CGFloat = 4
            static let textDateLeadingAnchor: CGFloat = 8
            static let textDateBottomAnchor: CGFloat = -16
            static let textDateTextColor = UIColor(hex: "C7C7C7")
        }
        enum Label {
            static let labelFontSize: CGFloat = 16
            static let labelTopAnchor: CGFloat = 16
            static let labelLeadingAnchor: CGFloat = 16
            static let labelTrailingAnchor: CGFloat = -16
            static let labelBottomAnchor: CGFloat = -16
        }
    }
}


