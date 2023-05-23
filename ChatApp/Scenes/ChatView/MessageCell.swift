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
    private lazy var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = .systemFont(ofSize: (Constants.Label.fontSize))
        label.numberOfLines = .zero
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(label)
        return label
    }()
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = Constants.Container.lightMode
        containerView.layer.cornerRadius = (Constants.Container.radius)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        return containerView
    }()
    
    private lazy var largeBubble: UIView = {
        let largeBubble = UIView()
        largeBubble.backgroundColor = Constants.Container.lightMode
        largeBubble.layer.cornerRadius = 8
        largeBubble.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(largeBubble)
        return largeBubble
    }()
    //private lazy var smallBubble = UIView()
    private lazy var textDate: UILabel = {
        let textDate = UILabel()
        textDate.textColor = Constants.TextDate.textColor
        textDate.font = .systemFont(ofSize: (Constants.TextDate.fontSize))
        textDate.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textDate)
        return textDate
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("error!")
    }
    
    func configure(with item: Message, isCurrentUser: Bool) {
        label.text = item.text
        setBubblePosition(isTrailing: isCurrentUser)
        
        if item.hasFailed == true {
            textDate.text = "არ გაიგზავნა"
            textDate.textColor = .red
        } else {
            textDate.textColor = Constants.TextDate.textColor
            textDate.text = item.date.formatDAte()
        }
    }
    
    private func setup() {
        contentView.backgroundColor = .clear
        setupContainerViewConstraints()
        setupLabelConstant()
        setupTextDateConstant()
        setupLargeBubbleConstraints()
        
        //        makeMinBubble()
        //        setupMinBubbleConstants()
    }
    
    func setAppearance(isDark: Bool) {
        containerView.backgroundColor = isDark ? Constants.Container.darkMode : Constants.Container.lightMode
        largeBubble.backgroundColor = isDark ? Constants.LargeBubble.darkMode : Constants.LargeBubble.lightMode
    }
    
    // MARK: - Make View
    
    //    func makeMinBubble () {
    //        largeBubble.backgroundColor = .blue
    //        largeBubble.layer.cornerRadius = 8
    //        contentView.addSubview(largeBubble)
    //    }
    
    // MARK: - Constraints
    
    private func setupContainerViewConstraints() {
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        leadingConstraints = [
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Container.leadingAnchor),
            containerView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: (-Constants.Container.trailingAnchor))
        ]
        trailingConstraints = [
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Container.leadingAnchor),
            containerView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: (Constants.Container.trailingAnchor))
        ]
    }
    
    func setupLargeBubbleConstraints() {
        NSLayoutConstraint.activate([
            largeBubble.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Constants.LargeBubble.bottomAnchor),
            largeBubble.widthAnchor.constraint(equalToConstant: Constants.LargeBubble.widthAnchor),
            largeBubble.heightAnchor.constraint(equalToConstant: Constants.LargeBubble.heightAnchor)
        ])
        leadingConstraints.append(largeBubble.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.LargeBubble.leadingAnchor))
        trailingConstraints.append(largeBubble.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Constants.LargeBubble.trailingAnchor))
    }
    
    //    func setupMinBubbleConstants() {
    //        smallBubble.translatesAutoresizingMaskIntoConstraints = false
    //        NSLayoutConstraint.activate([
    //
    //            smallBubble.widthAnchor.constraint(equalToConstant: 20),
    //            smallBubble.heightAnchor.constraint(equalToConstant: 20),
    //            smallBubble.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    //
    //        ])
    //
    //        leadingConstraints.append(smallBubble.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2))
    //        leadingConstraints.append(smallBubble.trailingAnchor.constraint(equalTo: largeBubble.leadingAnchor, constant: -2))
    //
    //        trailingConstraints.append(smallBubble.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2))
    //        trailingConstraints.append(smallBubble.leadingAnchor.constraint(equalTo: largeBubble.trailingAnchor, constant: 2))
    //    }
    
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
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: (Constants.Label.topAnchor)),
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: (Constants.Label.leadingAnchor)),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: (Constants.Label.trailingAnchor)),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: (Constants.Label.bottomAnchor))
        ])
    }
    
    private func setupTextDateConstant() {
        NSLayoutConstraint.activate([
            textDate.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: (Constants.TextDate.topAnchor)),
            textDate.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: (Constants.TextDate.bottomAnchor))
        ])
        
        leadingConstraints.append(textDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: (Constants.TextDate.leadingAnchor)))
        
        trailingConstraints.append(textDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: CGFloat(-Constants.TextDate.leadingAnchor)))
    }
}

// MARK: - Constants

extension MessageCell {
    enum Constants {
        enum Container {
            static let trailingAnchor: CGFloat = 16
            static let radius: CGFloat = 25
            static let leadingAnchor: CGFloat = 8
            static let lightMode = UIColor(hex: "F1F1F1")
            static let darkMode = UIColor(hex: "DAC2FF")
        }
        enum TextDate {
            static let fontSize: CGFloat = 12
            static let topAnchor: CGFloat = 4
            static let leadingAnchor: CGFloat = 8
            static let bottomAnchor: CGFloat = -16
            static let textColor = UIColor(hex: "C7C7C7")
        }
        enum Label {
            static let fontSize: CGFloat = 16
            static let topAnchor: CGFloat = 16
            static let leadingAnchor: CGFloat = 16
            static let trailingAnchor: CGFloat = -16
            static let bottomAnchor: CGFloat = -16
        }
        enum LargeBubble {
            static let bottomAnchor: CGFloat = 2
            static let widthAnchor: CGFloat = 16
            static let heightAnchor: CGFloat = 16
            static let leadingAnchor: CGFloat = -1
            static let trailingAnchor: CGFloat = 1
            static let lightMode = UIColor(hex: "F1F1F1")
            static let darkMode = UIColor(hex: "DAC2FF")
        }
    }
}
