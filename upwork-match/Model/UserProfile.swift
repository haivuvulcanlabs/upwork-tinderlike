//
//  UserProfile.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 11/12/2022.
//

import Foundation

struct UserProfile: Codable,Hashable {
    var id: String
    var fullname, username, email, profileImage: String?
    var profileImages: [String]
    var loginType: Int?
    var identity: String?
    var deviceType: Int?
    var deviceToken: String?
    var birthday: String?
    var bio: String?
    var authToken : String?
    
    func toJSON() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]else {
            
            return [:]
        }

        return json
    }
}
