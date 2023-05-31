//
//  ConversationViewModel.swift
//  ChatApp
//
//  Created by Giorgi Makadze on 29.04.2023.
//

import Foundation
import CoreData
import SystemConfiguration

class ConversationViewModel {
    private let coreDataManager: CoreDataManager
    private(set) var topViewModel: ChatViewModel
    private(set) var bottomViewModel: ChatViewModel
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
        let firstUserID = 1
        let secondUserID = 2
        
        topViewModel = ChatViewModel(userID: firstUserID, chatItems: [])
        bottomViewModel = ChatViewModel(userID: secondUserID, chatItems: [])
        
        let fetchedMessages = fetchMessages()
        
        topViewModel.chatItems += fetchedMessages.map { ChatItem.message($0) }
        bottomViewModel.chatItems += fetchedMessages.map { ChatItem.message($0) }
    }
    
    func startTyping(userId: Int) {
        if userId == topViewModel.userID {
            bottomViewModel.chatItems.append(.loading)
            print("ios - topview Start")
        } else if userId == bottomViewModel.userID {
            topViewModel.chatItems.append(.loading)
            print("ios-bottomview Start")
        }
    }
    
    func stopTyping(userId: Int) {
        if userId == topViewModel.userID {
            bottomViewModel.chatItems.removeAll(where: { $0 == .loading })
            print("ios - topview Stop")
        } else if userId == bottomViewModel.userID {
            topViewModel.chatItems.removeAll(where: { $0 == .loading })
            print("ios-bottomview Stop")
        }
    }
    
    func sendMessage(text: String, date: Date, userID: Int) {
        let isConnected = Reachability.isConnectedToNetwork()
        let hasFailed = !isConnected
        let message = Message(text: text, date: Date(), userID: userID, hasFailed: hasFailed)
        topViewModel.addMessage(message: message)
        bottomViewModel.addMessage(message: message)
        saveMessage(message: message)
    }
    
    func saveMessage(message: Message) {
        let newObject: MessageEntity = coreDataManager.createObject(entityName: "MessageEntity")
        newObject.text = message.text
        newObject.userID = Int64(message.userID)
        newObject.date = message.date
        newObject.hasFailed = message.hasFailed
        coreDataManager.saveContext()
    }
    
    func fetchMessages() -> [Message] {
        var messageArray: [Message] = []
        do {
            let fetchedObjects: [MessageEntity] = try coreDataManager.fetchObjects(entityName: "MessageEntity")
            for object in fetchedObjects {
                let text = object.text ?? ""
                let date = object.date ?? Date()
                let userID = object.userID
                let hasFailed = object.hasFailed
                let message = Message(text: text, date: date, userID: Int(userID), hasFailed: hasFailed)
                messageArray.append(message)
            }
        } catch {
            print("Failed to fetch objects: \(error)")
        }
        return messageArray
    }
}

