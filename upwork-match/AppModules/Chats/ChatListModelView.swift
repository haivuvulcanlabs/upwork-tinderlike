//
//  ChatListModelView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 03/12/2022.
//

import Foundation
import SwiftUI
import FirebaseFirestore

class ChatListModelView: ObservableObject {
    @Published var chats: [Chat] = []
    @Published var userDataListener : ListenerRegistration!
    @Published var userChatList = [FSUserChatList]()
    @Published var userIdentity = SessionManager.shared.profile?.identity ?? ""
    @Published var selectedChatlist = FSUserChatList(dict: [:])

    let db = Firestore.firestore()

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
    
    func fetchChatList() {
        if userIdentity == "" {
            return
        }
        self.userChatList.removeAll()
//        db.collection("/userchatlist/\(AllStaticData.userIdentity)/userlist")
//            .whereField(FireStoreConstants.isDeleted, isNotEqualTo: true)
        //            .addSnapshotListener { [self] (querySnapshot, err) in
        userDataListener = db.collection("/userchatlist/\(userIdentity)/userlist").order(by: FireStoreConstants.Time, descending: true).addSnapshotListener { [self] (querySnapshot, err) in
            self.userChatList.removeAll()
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                var tempData : [FSUserChatList] = []
                for document in querySnapshot!.documents {
                    print(document.data())
                    let user = FSUserChatList(dict: document.data())
                    if user.isDeleted == false {
                        tempData.append(user)
                    }
                }
                userChatList = tempData
//                userChatList = userChatList.sorted { lhs, rhs in
//                    return lhs.time > rhs.time
//                }
            }
        }
    }
    
    func deleteChatList()  {
        guard let partnerIdentity = selectedChatlist.user?.user_identity else {
            return 
        }
        let miliSecondDouble = round(Date().timeIntervalSince1970 * 1000)
        let miliSecondStr = String(format: "%.0f", miliSecondDouble)
        
        let ref = db.collection("/userchatlist/\(userIdentity)/userlist/").document(partnerIdentity)
        
        ref.updateData([
            FireStoreConstants.deletedId : miliSecondStr,
            FireStoreConstants.isDeleted : true
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Chat deleted")
            }
        }
    }
    
    
    func removeListener() {
        if userDataListener != nil { userDataListener.remove() }
    }
    
    func clearChat() {
        guard let partnerIdentity = selectedChatlist.user?.user_identity else {
            return
        }
        let time = "\(selectedChatlist.time)"
        let ref = db.collection("/userchatlist/\(userIdentity)/userlist/").document(partnerIdentity)
        
        ref.updateData([
            FireStoreConstants.deletedId : time,
            FireStoreConstants.LastMsg : ""
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Chat cleared")
            }
        }
    }
    
    func markAsUnread(partnerIdentity: String,value: Bool) {
        
        let ref = db.collection("/userchatlist/\(userIdentity)/userlist/").document(partnerIdentity)
        ref.updateData([
            FireStoreConstants.NewMsg : value
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("mark NewMsg: \(value)")
            }
        }
    }
}
