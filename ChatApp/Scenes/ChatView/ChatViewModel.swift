//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 18.05.2023.
//

import Foundation

struct ChatViewModel {
    let userID: Int
    var chatItems: [ChatItem]
    
    mutating func addMessage(message: Message) {
        chatItems.append(.message(message))
    }
    
    func isCurrentSender(messageSenderUserID: Int) -> Bool {
        self.userID == messageSenderUserID
    }
}
