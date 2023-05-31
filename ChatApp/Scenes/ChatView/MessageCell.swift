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
        largeBubble.layer.cornerRadius = Constants.LargeBubble.radius
        largeBubble.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(largeBubble)
        return largeBubble
    }()
    
    private lazy var textDate: UILabel = {
        let textDate = UILabel()
        textDate.textColor = Constants.TextDate.textColor
        textDate.font = .systemFont(ofSize: (Constants.TextDate.fontSize))
        textDate.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textDate)
        return textDate
    }()
    
    private lazy var smallBubble: UIView = {
        let smallBubble = UIView()
        smallBubble.backgroundColor = Constants.Container.lightMode
        smallBubble.layer.cornerRadius = Constants.SmallBubble.radius
        smallBubble.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(smallBubble)
        return smallBubble
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
        if item.hasFailed {
            textDate.text = Constants.TextDate.text
            textDate.textColor = .red
        } else {
            textDate.textColor = Constants.TextDate.textColor
            textDate.text = item.date.formatDAte()
        }
    }
    
    private func setup() {
        contentView.backgroundColor = .clear
        setupSmallBubbleConstants()
        setupLargeBubbleConstraints()
        setupContainerViewConstraints()
        setupLabelConstant()
        setupTextDateConstant()
    }
    
    // MARK: - Constraints
    
    private func setupContainerViewConstraints() {
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: largeBubble.topAnchor, constant: Constants.Container.bottomAnchor).isActive = true
        leadingConstraints.append(contentsOf: [
            containerView.leadingAnchor.constraint(equalTo: largeBubble.trailingAnchor, constant: Constants.Container.leadingAnchor),
            containerView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: (-Constants.Container.trailingAnchor))
        ])
        trailingConstraints.append(contentsOf: [
            containerView.trailingAnchor.constraint(equalTo: largeBubble.leadingAnchor, constant: -Constants.Container.leadingAnchor),
            containerView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: (Constants.Container.trailingAnchor))
        ])
    }
    
    func setupLargeBubbleConstraints() {
        NSLayoutConstraint.activate([
            largeBubble.bottomAnchor.constraint(equalTo: smallBubble.topAnchor, constant: Constants.LargeBubble.bottomAnchor),
            largeBubble.widthAnchor.constraint(equalToConstant: Constants.LargeBubble.widthAnchor),
            largeBubble.heightAnchor.constraint(equalToConstant: Constants.LargeBubble.heightAnchor)
        ])
        leadingConstraints.append(largeBubble.leadingAnchor.constraint(equalTo: smallBubble.trailingAnchor, constant: Constants.LargeBubble.leadingAnchor))
        trailingConstraints.append(largeBubble.trailingAnchor.constraint(equalTo: smallBubble.leadingAnchor, constant: Constants.LargeBubble.trailingAnchor))
    }
    
    func setupSmallBubbleConstants() {
        NSLayoutConstraint.activate([
            smallBubble.widthAnchor.constraint(equalToConstant: Constants.SmallBubble.widthAnchor),
            smallBubble.heightAnchor.constraint(equalToConstant: Constants.SmallBubble.heightAnchor),
        ])
        leadingConstraints.append(smallBubble.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.SmallBubble.leadingAnchor))
        trailingConstraints.append(smallBubble.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.SmallBubble.trailingAnchor))
    }
    
    private func setBubblePosition(isTrailing: Bool) {
        if isTrailing {
            NSLayoutConstraint.activate(trailingConstraints)
            NSLayoutConstraint.deactivate(leadingConstraints)
            containerView.backgroundColor = Constants.Container.darkMode
            largeBubble.backgroundColor = Constants.LargeBubble.darkMode
            smallBubble.backgroundColor = Constants.LargeBubble.darkMode
        } else {
            NSLayoutConstraint.activate(leadingConstraints)
            NSLayoutConstraint.deactivate(trailingConstraints)
            containerView.backgroundColor = Constants.Container.lightMode
            largeBubble.backgroundColor = Constants.LargeBubble.lightMode
            smallBubble.backgroundColor = Constants.LargeBubble.lightMode
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
            textDate.topAnchor.constraint(equalTo: smallBubble.bottomAnchor, constant: (Constants.TextDate.topAnchor)),
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
            static let leadingAnchor: CGFloat = -14
            static let bottomAnchor: CGFloat = 16
            static let lightMode = UIColor(hex: "F1F1F1")
            static let darkMode = UIColor(hex: "DAC2FF")
        }
        enum TextDate {
            static let fontSize: CGFloat = 12
            static let topAnchor: CGFloat = 4
            static let leadingAnchor: CGFloat = 8
            static let bottomAnchor: CGFloat = -16
            static let text = "არ გაიგზავნა"
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
            static let radius: CGFloat = 8
            static let lightMode = UIColor(hex: "F1F1F1")
            static let darkMode = UIColor(hex: "DAC2FF")
        }
        enum SmallBubble {
            static let radius: CGFloat = 6
            static let widthAnchor: CGFloat = 12
            static let heightAnchor: CGFloat = 12
            static let leadingAnchor: CGFloat = 2
            static let trailingAnchor: CGFloat = -2
        }
    }
}
