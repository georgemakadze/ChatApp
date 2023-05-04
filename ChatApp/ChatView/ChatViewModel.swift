//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 29.04.2023.
//

import Foundation
import UIKit

class ChatViewModel {
    private(set) var myMessages: [Message] = [
        Message(text: "Hello, how are you?", date: "მარ 14,16:00", sender: .other),
        Message(text: "I'm doing well, thank you. How about you?", date: "მარ 14,16:05", sender: .me),
        Message(text: "I'm good, thanks!", date: "მარ 14,16:15", sender: .other)
    ]
    
    private(set) var otherMessages: [Message] = [
        Message(text: "Hello, how are you?", date: "მარ 14,16:00", sender: .me),
        Message(text: "I'm doing well, thank you. How about you?", date: "მარ 14,16:05", sender: .other),
        Message(text: "I'm good, thanks!", date: "მარ 14,16:15", sender: .me)
    ]
    
    func sendMessage(text: String, date: Date, sender: Sender) {
        switch sender {
        case .other:
            let otherMessage = Message(text: text, date: "TODO", sender: .me)
            let myMessage = Message(text: text, date: "TODO", sender: .other)
            
            myMessages.append(myMessage)
            otherMessages.append(otherMessage)
        case .me:
            let otherMessage = Message(text: text, date: "TODO", sender: .other)
            let myMessage = Message(text: text, date: "TODO", sender: .me)
            
            myMessages.append(myMessage)
            otherMessages.append(otherMessage)
        }
    }
    
}

