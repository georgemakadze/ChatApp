//
//  Messages.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 29.04.2023.
//

import Foundation

struct Message: Hashable {
    let id = UUID().uuidString
    let text: String
    let date: String
    let sender: Sender
    init(text: String, date: String, sender: Sender) {
        self.text = text
        self.date = date
        self.sender = sender
    }
}

enum Sender {
    case Me
    case Other
}

