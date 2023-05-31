//
//  ChatItem.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 31.05.2023.
//

import Foundation

enum ChatItem: Hashable {
    case message(Message)
    case loading
}
