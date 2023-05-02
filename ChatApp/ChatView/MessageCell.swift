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
    //    let elipse = UIView()
    let textDate = UILabel()
    //    let label2 = UILabel()
    
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
    
    //    func makeLabel2() {
    //        label2.backgroundColor = .clear
    //        label2.textColor = .black
    //        label2.font = UIFont.systemFont(ofSize: CGFloat(Constants.labelFontSize))
    //        label2.numberOfLines = .zero
    //        label2.lineBreakMode = .byWordWrapping
    //        containerView.addSubview(label2)
    //    }
    
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
    
    //    func otherConteinerConstants() {
    //        containerView.translatesAutoresizingMaskIntoConstraints = false
    //        NSLayoutConstraint.activate([
    //            //            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
    //            containerView.leadingAnchor.constraint(equalTo: label2.leadingAnchor, constant: -16),
    //            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
    //            //containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    //        ])
    //    }
    
    //    func otherLabel() {
    //        label2.translatesAutoresizingMaskIntoConstraints = false
    //        NSLayoutConstraint.activate([
    //            label2.topAnchor.constraint(equalTo: containerView.topAnchor, constant: CGFloat(Constants.labelTopAnchor)),
    //            label2.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: CGFloat(Constants.labelBottomAnchor)),
    //            label2.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
    //            label2.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
    //
    //        ])
    //    }
    
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


