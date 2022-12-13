//
//  UserProfile.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 11/12/2022.
//

import Foundation

struct UserProfile: Codable,Hashable {
    var id: String
    var fullname, username: String?
    var profileImages: [String]
    var loginType: Int?
    var identity: String?
    var deviceType: Int?
    var deviceToken: String?
    var birthday: String?
    var gender: Gender?
    var bio: String?
    var bithday: String?
    var age: Int?
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

extension Encoder {
    
}

struct PlusSetting: Codable, Hashable {
    static let `default` = PlusSetting(unlimitedLike: false, unlimitedMsg: false, dontShowAge: false, dontShowDistance: false, hideMyProfile: false)

    var unlimitedLike:  Bool
    var unlimitedMsg: Bool
    var dontShowAge: Bool
    var dontShowDistance: Bool
    var hideMyProfile: Bool
    
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
