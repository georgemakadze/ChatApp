//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 18.05.2023.
//

import Foundation

struct ChatViewModel {
    let userID: Int
    var messages: [Message]
    var isLoading = false
    
    var chatItemsCount: Int {
        return messages.count + (isLoading ? 1 : 0)
    }
    
    mutating func addMessage(message: Message) {
        messages.append(message)
    }
    
    func isCurrentSender(messageSenderUserID: Int) -> Bool {
        self.userID == messageSenderUserID
    }
}
