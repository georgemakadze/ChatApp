//
//  InputView.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 04.05.2023.
//

import Foundation
import UIKit

protocol InputViewDelegate: AnyObject {
    func didtapSendButton(inputView: InputView, text: String, date: Date)
}

class InputView: UIView {
    
    // MARK: - Properties
    
    private let textView = UITextView()
    private let button = UIButton(type: .custom)
    private let containerView = UIView()
    
    weak var delegate: InputViewDelegate?
    
    // MARK: - Lifecycle Methods
    
    required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }
    
    func setup() {
        makeContainer()
        makeButton()
        makeTextView()
        setupContainerViewConstraints()
        setupTextViewConstraints()
        setupButtonConstraints()
    }
    
    private func makeContainer() {
        containerView.backgroundColor = Constants.ContainerView.backgroundColor
        containerView.layer.borderColor = Constants.ContainerView.layerBorderColor
        containerView.layer.borderWidth = (Constants.ContainerView.layerBorderWidth)
        containerView.layer.cornerRadius = (Constants.ContainerView.layerCornerRadius)
        addSubview(containerView)
    }
    
    private func makeButton() {
        button.setImage(Constants.Button.image, for: .normal)
        button.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
        containerView.addSubview(button)
    }
    
    private func makeTextView() {
        textView.backgroundColor = .clear
        textView.textAlignment = .left
        textView.textColor = Constants.TextView.textColor
        textView.font = .systemFont(ofSize:(Constants.TextView.fontSize))
        textView.text = Constants.TextView.text
        containerView.addSubview(textView)
    }
    
    private func setupContainerViewConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: (Constants.ContainerView.padding)),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: (-Constants.ContainerView.padding)),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: (-Constants.ContainerView.padding))
        ])
    }
    
    private func setupTextViewConstraints() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: (Constants.TextView.leadingAnchor)),
            textView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: (Constants.TextView.bottomAnchor)),
            textView.heightAnchor.constraint(equalToConstant: (Constants.TextView.heightAnchor)),
            textView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: (Constants.TextView.topAnchor))
        ])
    }
    
    private func setupButtonConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: (Constants.Button.trailingAnchor)),
            button.topAnchor.constraint(equalTo: containerView.topAnchor),
            button.leadingAnchor.constraint(equalTo: textView.trailingAnchor, constant: (Constants.Button.leadingAnchor))
        ])
    }
    
    @objc private func didTapSendButton() {
        if let message = textView.text {
            delegate?.didtapSendButton(inputView: self, text: message, date: Date())
        }
    }
    
    func setAppearance(isDark: Bool) {
        backgroundColor = isDark ? Constants.backgroundColor : .white
        containerView.backgroundColor = isDark ?  Constants.ContainerView.darkCBackgroundColor : .white
        textView.textColor = isDark ?  .white : .black
    }
}

extension InputView {
    enum Constants {
        enum TextView {
            static let leadingAnchor: CGFloat = 16
            static let bottomAnchor: CGFloat = -8
            static let heightAnchor: CGFloat = 44
            static let topAnchor: CGFloat = 8
            static let fontSize: CGFloat = 16
            static let textColor = UIColor(hex: "C7C7C7")
            static let text = "დაწერეთ შეტყობინება..."
        }
        enum Button {
            static let trailingAnchor: CGFloat = -8
            static let leadingAnchor: CGFloat = 10
            static let image = UIImage(named: "send")
        }
        enum ContainerView {
            static let padding: CGFloat = 16
            static let layerBorderWidth: CGFloat = 1
            static let layerCornerRadius: CGFloat = 28
            static let backgroundColor = UIColor(hex: "F1F1F1")
            static let layerBorderColor = UIColor(hex: "9F60FF").cgColor
            static let darkCBackgroundColor = UIColor(hex: "160039")
        }
        static let backgroundColor = UIColor(hex: "160039")
    }
}
