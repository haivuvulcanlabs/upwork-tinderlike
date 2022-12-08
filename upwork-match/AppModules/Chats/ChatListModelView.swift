//
//  ChatListModelView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 03/12/2022.
//

import Foundation
import SwiftUI

class ChatListModelView: ObservableObject {
    @Published var chats: [Chat] = []
    
    func getChatList() {
        var chats: [Chat] = []
        for index in 0 ..< 10 {
            let chat = Chat(id: index, message: "message \(index)")
            chats.append(chat)
        }
        
        self.chats = chats
    }
    
    func removeChat(at index: Int) {
        chats.remove(at: index)
    }
    
    func removeChat(by id: Int) {
        chats.removeAll(where: {$0.id == id})
    }
}
