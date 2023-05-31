//
//  LoadingCell.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 25.05.2023.
//

import Foundation
import UIKit

class LoadingCell: UICollectionViewCell {
    
    private lazy var smallBubble: UIView = {
        let firstBubble = UIView()
        firstBubble.backgroundColor = UIColor(hex: "F1F1F1")
        firstBubble.layer.cornerRadius = 6
        firstBubble.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(firstBubble)
        return firstBubble
    }()
    
    private lazy var largeBubble: UIView = {
        let secondBubble = UIView()
        secondBubble.backgroundColor = UIColor(hex: "F1F1F1")
        secondBubble.layer.cornerRadius = 8
        secondBubble.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(secondBubble)
        return secondBubble
    }()
    
    private lazy var containerBubble: UIView = {
        let thirdBubble = UIView()
        thirdBubble.backgroundColor = UIColor(hex: "F1F1F1")
        thirdBubble.layer.cornerRadius = 25
        thirdBubble.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(thirdBubble)
        return thirdBubble
    }()
    
    private lazy var firstCircleBubble: UIView = {
        let firstCircleBubble = UIView()
        firstCircleBubble.backgroundColor = .lightGray
        firstCircleBubble.layer.cornerRadius = 4
        firstCircleBubble.translatesAutoresizingMaskIntoConstraints = false
        containerBubble.addSubview(firstCircleBubble)
        return firstCircleBubble
    }()
    
    private lazy var secondCircleBubble: UIView = {
        let secondCircleBubble = UIView()
        secondCircleBubble.backgroundColor = .lightGray
        secondCircleBubble.layer.cornerRadius = 4
        secondCircleBubble.translatesAutoresizingMaskIntoConstraints = false
        containerBubble.addSubview(secondCircleBubble)
        return secondCircleBubble
    }()
    
    private lazy var thirdCircleBubble: UIView = {
        let thirdCircleBubble = UIView()
        thirdCircleBubble.backgroundColor = .lightGray
        thirdCircleBubble.layer.cornerRadius = 4
        thirdCircleBubble.translatesAutoresizingMaskIntoConstraints = false
        containerBubble.addSubview(thirdCircleBubble)
        return thirdCircleBubble
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("error!")
    }
    
    private func setup() {
        contentView.backgroundColor = .clear
        setupFirstBubbleConstants()
        setupSecondBubbleConstraints()
        setupThirdBubbleConstraints()
        setupFirstCircleBubbleConstraints()
        setupSecondCircleBubbleConstraints()
        setupThirdCircleBubbleConstraints()
    }
    
    func setupFirstBubbleConstants() {
        NSLayoutConstraint.activate([
            smallBubble.widthAnchor.constraint(equalToConstant: 12),
            smallBubble.heightAnchor.constraint(equalToConstant: 12),
            smallBubble.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            smallBubble.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupSecondBubbleConstraints() {
        NSLayoutConstraint.activate([
            largeBubble.bottomAnchor.constraint(equalTo: smallBubble.topAnchor, constant: 2),
            largeBubble.widthAnchor.constraint(equalToConstant: 16),
            largeBubble.heightAnchor.constraint(equalToConstant: 16),
            largeBubble.leadingAnchor.constraint(equalTo: smallBubble.trailingAnchor, constant: -1)
        ])
    }
    
    private func setupThirdBubbleConstraints() {
        NSLayoutConstraint.activate([
            containerBubble.widthAnchor.constraint(equalToConstant: 100),
            containerBubble.heightAnchor.constraint(equalToConstant: 44),
            containerBubble.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerBubble.bottomAnchor.constraint(equalTo: largeBubble.topAnchor, constant: 16),
            containerBubble.leadingAnchor.constraint(equalTo: largeBubble.trailingAnchor, constant: -14)
        ])
        
    }
    
    func setupFirstCircleBubbleConstraints() {
        NSLayoutConstraint.activate([
            firstCircleBubble.widthAnchor.constraint(equalToConstant: 10),
            firstCircleBubble.heightAnchor.constraint(equalToConstant: 10),
            firstCircleBubble.leadingAnchor.constraint(equalTo: containerBubble.leadingAnchor, constant: 20),
            firstCircleBubble.centerYAnchor.constraint(equalTo: containerBubble.centerYAnchor)
        ])
    }
    
    func setupSecondCircleBubbleConstraints() {
        NSLayoutConstraint.activate([
            secondCircleBubble.widthAnchor.constraint(equalToConstant: 10),
            secondCircleBubble.heightAnchor.constraint(equalToConstant: 10),
            secondCircleBubble.leadingAnchor.constraint(equalTo: firstCircleBubble.trailingAnchor, constant: 10),
            secondCircleBubble.centerYAnchor.constraint(equalTo: containerBubble.centerYAnchor)
        ])
    }
    
    func setupThirdCircleBubbleConstraints() {
        NSLayoutConstraint.activate([
            thirdCircleBubble.widthAnchor.constraint(equalToConstant: 10),
            thirdCircleBubble.heightAnchor.constraint(equalToConstant: 10),
            thirdCircleBubble.leadingAnchor.constraint(equalTo: secondCircleBubble.trailingAnchor, constant: 10),
            thirdCircleBubble.centerYAnchor.constraint(equalTo: containerBubble.centerYAnchor)
        ])
    }
}
