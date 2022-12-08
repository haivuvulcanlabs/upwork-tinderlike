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
        let chatMessage = ChatMessage(id: UUID().uuidString, message: message)
        chatMessages.append(chatMessage)
        
        //
        chatString = ""
    }
}
