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
        
        topViewModel = ChatViewModel(userID: firstUserID, messages: [])
        bottomViewModel = ChatViewModel(userID: secondUserID, messages: [])
        
        let fetchedMessages = fetchMessages()
        
        topViewModel.messages += fetchedMessages
        bottomViewModel.messages += fetchedMessages
    }
    
    func startTyping(userId: Int) {
        bottomViewModel.isLoading = userId == topViewModel.userID
        topViewModel.isLoading = userId == bottomViewModel.userID
    }
    
    func stopTyping(userId: Int) {
        bottomViewModel.isLoading = userId != topViewModel.userID
        topViewModel.isLoading = userId != bottomViewModel.userID
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

