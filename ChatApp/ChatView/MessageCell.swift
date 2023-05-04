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
    private let containerView = UIView()
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
        item.sender == .me ? setTrailing() : setLeading()
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
    
    // MARK: - Make container
    
    private func makeContainer() {
        containerView.backgroundColor = Constants.containerViewBackgroundColor
        containerView.layer.cornerRadius = CGFloat(Constants.containerViewRadius)
        contentView.addSubview(containerView)
    }
    
    // MARK: - Make textDate
    
    private func makeTextDate() {
        textDate.textColor = Constants.textDateTextColor
        textDate.font = .systemFont(ofSize: CGFloat(Constants.textDateFontSize))
        contentView.addSubview(textDate)
    }
    
    // MARK: - Make label
    
    private func makeLabel() {
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = .systemFont(ofSize: CGFloat(Constants.labelFontSize))
        label.numberOfLines = .zero
        label.lineBreakMode = .byWordWrapping
        containerView.addSubview(label)
    }
    
    // MARK: - ContainerView constants
    
    private func setupContainerViewConstant() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        leadingConstraints = [
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: CGFloat(-Constants.containerViewTrailingAnchor))
        ]
        trailingConstraints = [
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: CGFloat(Constants.containerViewTrailingAnchor))
        ]
    }
    
    private func setTrailing() {
        NSLayoutConstraint.activate(trailingConstraints)
        NSLayoutConstraint.deactivate(leadingConstraints)
    }
    
    private func setLeading() {
        NSLayoutConstraint.activate(leadingConstraints)
        NSLayoutConstraint.deactivate(trailingConstraints)
    }
    
    // MARK: - Label constants
    
    private func setupLabelConstant() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: CGFloat(Constants.labelTopAnchor)),
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: CGFloat(Constants.labelLeadingAnchor)),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: CGFloat(Constants.labelTrailingAnchor)),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: CGFloat(Constants.labelBottomAnchor))
        ])
    }
    
    // MARK: - Textdate constants
    
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

// MARK: - Constants

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


