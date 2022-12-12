//
//  SessionManager.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 11/12/2022.
//

import Foundation

class SessionManager {
    static var shared = SessionManager()
    var profile: UserProfile?
    
    func saveUser(profile: UserProfile) {
        self.profile = profile
        
        let data = try? JSONEncoder().encode(profile)
        UserDefaults.standard.set(data, forKey: "user_profile_data")
    }
    
    func getUser() {
        guard let data = UserDefaults.standard.data(forKey: "user_profile_data") else {
            return
        }
        
        profile = try? JSONDecoder().decode(UserProfile.self, from: data)
    }
    
    //    //MARK: purchaseData
    func setStoreConfigs(datum: [StoreConfig]) {
        do {
            let data = try JSONEncoder().encode(datum)
            let dataString = String(decoding: data, as: UTF8.self)
            setStringValue(value: dataString, key: "coin_plan_data")
        } catch let err {
            print(err.localizedDescription)
        }
        
    }
    
    func getStoreConfigs() -> [StoreConfig] {
        let dataString = getStringValueForKey(key: "coin_plan_data")
        let data = Data(dataString.utf8)
        if let loaded = try? JSONDecoder().decode([StoreConfig].self, from: data) {
            return loaded
        }
        return []
    }
}


extension SessionManager {
    //MARK: Bool
    func getBooleanValueForKey(key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    func setBooleanValue(value: Bool, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    //MARK:  String
    func getStringValueForKey(key: String) -> String {
        if let value = UserDefaults.standard.string(forKey: key) {
            return value
        }
        
        return ""
    }
    func setStringValue(value: String, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    //MARK: Int
    func getIntegerValueForKey(key: String) -> Int {
        return UserDefaults.standard.integer(forKey: key)
    }
    func setIntegerValue(value: Int, key: String) {
        
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    //MARK: Float
    func getFloatValueForKey(key: String) -> Float {
        return UserDefaults.standard.float(forKey: key)
    }
    func setFloatValue(value: Float, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    
    //MARK: Clear
    func clear() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
}
