//
//  SettingViewModel.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 01/12/2022.
//

import Foundation
import SwiftUI
import FirebaseAuth
class SettingViewModel: ObservableObject {
    static let shared = SettingViewModel()
    let items: [AppSettingGroup] = AppSettingGroup.allCases
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            AppFlow.shared.isLoggedIn = false
        } catch {
            
        }
    }
}
