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
        Message(text: "Hello, how are you?", date: "მარ 14,16:00", sender: .Other),
        Message(text: "I'm doing well, thank you. How about you?", date: "მარ 14,16:05", sender: .Me),
        Message(text: "I'm good, thanks!", date: "მარ 14,16:15", sender: .Other)
    ]
    
    private(set) var otherMessages: [Message] = [
        Message(text: "Hello, how are you?", date: "მარ 14,16:00", sender: .Me),
        Message(text: "I'm doing well, thank you. How about you?", date: "მარ 14,16:05", sender: .Other),
        Message(text: "I'm good, thanks!", date: "მარ 14,16:15", sender: .Me)
    ]
}

