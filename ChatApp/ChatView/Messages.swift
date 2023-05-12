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
    let userID: Int
}
