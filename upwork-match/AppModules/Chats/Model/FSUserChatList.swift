//
//  FSUserChatList.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 17/12/2022.
//

import Foundation

struct FSUserChatList : Hashable {
    static func == (lhs: FSUserChatList, rhs: FSUserChatList) -> Bool {
        return true
    }
    
    
    
    var block: Bool
    var blockFromOther: Bool
    var isMute: Bool
    var conversationId: String
    var group: Bool
    var newMsg: Bool
    var isDeleted : Bool
    var deletedId : String
    var time: Int
    var user: FSUser?
    var lastMsg: String
    
    init(dict: [String: Any]) {
        
        self.block                      = dict[FireStoreConstants.Block] as? Bool ?? false
        self.blockFromOther             = dict[FireStoreConstants.BlockFromOther] as? Bool ?? false
        self.isMute                     = dict[FireStoreConstants.IsMute] as? Bool ?? false
        self.conversationId             = dict[FireStoreConstants.ConversationId] as? String ?? ""
        self.group                      = dict[FireStoreConstants.Group] as? Bool ?? false
        self.newMsg                     = dict[FireStoreConstants.NewMsg] as? Bool ?? false
        self.time                       = dict[FireStoreConstants.Time] as? Int ?? 0
        self.lastMsg                    = dict[FireStoreConstants.LastMsg] as? String ?? ""
        self.isDeleted                  = dict[FireStoreConstants.isDeleted] as? Bool ?? false
        self.deletedId                  = dict[FireStoreConstants.deletedId] as? String ?? ""
        
        if let userDict = dict[FireStoreConstants.User] as? [String: Any] {
            //            self.user                   = FSUser(userDict)
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: userDict, options: .prettyPrinted)
                
                self.user = try JSONDecoder().decode(FSUser.self, from: jsonData)
                
            } catch {
                self.user = nil
            }
            
            
        } else {
            self.user = nil
        }
    }
    
    func getDictionary() -> [String: Any] {
        var tempDict = [String: Any]()
        
        tempDict[FireStoreConstants.Block]              = self.block
        tempDict[FireStoreConstants.BlockFromOther]     = self.blockFromOther
        tempDict[FireStoreConstants.IsMute]             = self.isMute
        tempDict[FireStoreConstants.ConversationId]     = self.conversationId
        tempDict[FireStoreConstants.Group]              = self.group
        tempDict[FireStoreConstants.NewMsg]             = self.newMsg
        tempDict[FireStoreConstants.Time]               = self.time
        tempDict[FireStoreConstants.User]               = self.user.dictionary ?? [:]
        tempDict[FireStoreConstants.LastMsg]            = self.lastMsg
        tempDict[FireStoreConstants.isDeleted]            = self.isDeleted
        tempDict[FireStoreConstants.deletedId]            = self.deletedId
        return tempDict
    }
}


extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
