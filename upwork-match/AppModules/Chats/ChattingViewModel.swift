//
//  ChattingViewModel.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 08/12/2022.
//

import Foundation
import SwiftUI

class ChattingViewModel: ObservableObject {
    @Published var chatString: String = ""
    @Published var chatMessages: [ChatMessage] = []
    
    func sendMessage(_ message: String) {
        let sender = FSUser(date: Date().timeIntervalSince1970, user_image: "", is_new_msg: false, selected: false, user_identity: "hai_vu", user_name: "hai_vu", age: "30", user_id: 1, is_verified: true, full_name: "Hai vu")
        let chatMessage = ChatMessage(id: UUID().uuidString, message: message.trimmingCharacters(in: .whitespacesAndNewlines), senderUser: sender, time: Date().timeIntervalSince1970)
        chatMessages.append(chatMessage)
        
        //
        chatString = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.autoReply()
        }
    }
    
    func autoReply() {
        let randomMessage = ChatMessage.randomMessage
        
        chatMessages.append(randomMessage)
    }
}
