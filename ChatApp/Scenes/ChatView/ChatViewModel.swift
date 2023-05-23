//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 18.05.2023.
//

import Foundation

struct ChatViewModel {
    let userID: Int
//    let hasFailed: Bool
    var messages: [Message]
    
    mutating func addMessage(message: Message) {
        messages.append(message)
    }
    
    func isCurrentSender(messageSenderUserID: Int) -> Bool {
        self.userID == messageSenderUserID
    }
}
