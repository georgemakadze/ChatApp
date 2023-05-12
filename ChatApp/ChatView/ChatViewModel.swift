//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 29.04.2023.
//

import Foundation
import UIKit

class ChatViewModel {
    let topUserID = 1
    let bottomUserID = 2
    
    private(set) lazy var allMessages: [Message] = [
        Message(text: "Hello, how are you?", date: Date(), userID: topUserID),
        Message(text: "I'm doing well, thanks. How about you?", date: Date(), userID: bottomUserID),
        Message(text: "I'm good, thanks!", date: Date(), userID: topUserID),
        Message(text: "Okay bye", date: Date(), userID: bottomUserID),
    ]
    
    func sendMessage(text: String, date: Date, userID: Int) {
        let message = Message(text: text, date: Date(), userID: userID)
        allMessages.append(message)
    }
}
