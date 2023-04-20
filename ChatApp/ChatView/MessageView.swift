//
//  MessageView.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 19.04.2023.
//

import Foundation
import UIKit

class MessageView: UIView, UITextViewDelegate {
    let textView = UITextField()
    let button = UIButton(type: .custom)
    
    func setupView() {
        backgroundColor = .white
    }
    
    func setupButton() {
        
        button.setImage(UIImage(named: "send"), for: .normal)
        
        let buttonSize = CGSize(width: 40, height: 40)
        button.frame = CGRect(origin: CGPoint.zero, size: buttonSize)
        
        let buttonView = UIView(frame: button.frame)
        buttonView.addSubview(button)
        buttonView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: buttonSize.width + 16, height: buttonSize.height))
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 40))
        
        textView.rightView = buttonView
        textView.rightViewMode = .always
        textView.leftView = leftView
        textView.leftViewMode = .always
    }
    
    func textInput() {
        
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = .black
        textView.textAlignment = .left
        textView.backgroundColor = .white
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.systemPink.cgColor
        textView.layer.cornerRadius = 25
        self.addSubview(textView)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            textView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15)
        ])
    }
}
