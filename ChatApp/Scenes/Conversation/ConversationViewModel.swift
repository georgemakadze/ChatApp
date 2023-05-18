//
//  ConversationViewModel.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 29.04.2023.
//

import Foundation
import UIKit

class ConversationViewModel {
    private(set) var topViewModel: ChatViewModel
    private(set) var bottomViewModel: ChatViewModel
    
    init() {
        let firstUserID = 1
        let secondUserID = 2
        
        let fakeMessages: [Message] = [
            Message(text: "Hello, how are you?", date: Date(), userID: firstUserID),
            Message(text: "I'm doing well, thanks. How about you?", date: Date(), userID: secondUserID),
            Message(text: "I'm good, thanks!", date: Date(), userID: firstUserID),
            Message(text: "Okay bye", date: Date(), userID: secondUserID),
        ]
        topViewModel = ChatViewModel(userID: firstUserID, messages: fakeMessages)
        bottomViewModel = ChatViewModel(userID: secondUserID, messages: fakeMessages)
    }
    
    func sendMessage(text: String, date: Date, userID: Int) {
        let message = Message(text: text, date: Date(), userID: userID)
        topViewModel.addMessage(message: message)
        bottomViewModel.addMessage(message: message)
    }
    
    
}
