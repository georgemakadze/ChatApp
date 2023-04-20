//
//  MessageView.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 19.04.2023.
//

import Foundation
import UIKit

class MessageView: UIView, UITextViewDelegate {
   
    
    func setupView() {
        backgroundColor = .white
      }
    
   
    
    func textInput() {

        let textView = UITextView()
        //textView.frame = CGRect(x: 50, y:60, width: 50, height: 30) // set the size and position of the UITextView
        textView.font = UIFont.systemFont(ofSize: 10) // set the font size
        textView.textColor = .white // set the text color
        textView.textAlignment = .left // set the text alignment
        textView.isEditable = true // set if the text view is editable
        textView.isSelectable = true // set if the text view is selectable
        textView.backgroundColor = .white // set the background color
        textView.layer.borderWidth = 1.0 // set the border width
        textView.layer.borderColor = UIColor.systemPink.cgColor // set the border color
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
    
    

