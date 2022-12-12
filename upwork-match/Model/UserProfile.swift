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
    
    var plusSetting: PlusSetting
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


struct PlusSetting: Codable, Hashable {
    let unlimitedLike:  Bool
    let unlimitedMsg: Bool
    let dontShowAge: Bool
    let dontShowDistance: Bool
    let hideMyProfile: Bool
    
    static let `default` = PlusSetting(unlimitedLike: false, unlimitedMsg: false, dontShowAge: false, dontShowDistance: false, hideMyProfile: false)
}
