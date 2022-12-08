//
//  ChatMessage.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 08/12/2022.
//

import Foundation

struct ChatMessage: Identifiable {
    let id: String
    let message: String
    var receiverUser: FSUser!
    var senderUser: FSUser!
    var time: Double
    
    static let randomMessage = ChatMessage(id: UUID().uuidString, message: ["Hello, how are you?", "Are interested on you!", "Famers market is at Pasadena", "I am fine, thank you!"].randomElement() ?? "", receiverUser: FSUser.randomUser, senderUser: FSUser.randomUser, time: Date().timeIntervalSince1970)
}


struct FSUser : Hashable,Codable {
    static func == (lhs: FSUser, rhs: FSUser) -> Bool {
        return lhs.date == rhs.date && lhs.date == rhs.date && lhs.date == rhs.date
    }
    
    
    var date: Double
    var user_image: String
    var is_new_msg: Bool
    var selected: Bool
    var user_identity: String
    var user_name: String
    var age: String
    var user_id: Int
    var is_verified : Bool
    var full_name : String
    
    static let randomUser: FSUser = FSUser(date: Date().timeIntervalSince1970, user_image: "", is_new_msg: true, selected: false, user_identity: UUID().uuidString, user_name: "sara", age: "20", user_id: 1, is_verified: true, full_name: "Sara")
}
