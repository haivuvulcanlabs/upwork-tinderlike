//
//  SessionManager.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 11/12/2022.
//

import Foundation

class SessionManager {
    static var shared = SessionManager()
    
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
