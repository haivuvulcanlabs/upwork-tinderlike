//
//  AppSetting.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 01/12/2022.
//

import Foundation

enum AppSetting: Int, CaseIterable {
    case manageSubscription = 0
    case deleteAccount
    case pushNotification
    case privaryPolicy
    case termsOfService
    case support
    
    var text: String {
        switch self {
        case .manageSubscription:
            return "Manage Subscription"
        case .deleteAccount:
            return "Delete account"
        case .pushNotification:
            return "Push notification"
        case .privaryPolicy:
            return "Privary Policy"
        case .termsOfService:
            return "Terms of Service"
        case .support:
            return "Help and support"
        }
    }
}


enum AppSettingGroup: Int, CaseIterable {
    case account = 0, pushNotification, legel, contactUs
    
    var items: [AppSetting] {
        switch self {
        case .account:
            return [.manageSubscription, .deleteAccount]
        case .pushNotification:
            return [.pushNotification]
        case .legel:
            return [.privaryPolicy, .termsOfService]
        case .contactUs:
            return [.support]
        }
    }
    
    var text: String {
        switch self {
        case .account:
            return "ACCOUNT SETTINGS"
        case .pushNotification:
            return "NOTIFICATION"
        case .legel:
            return "LEGAL"
        case .contactUs:
            return "CONTACT US"
        }
        
    }
}
