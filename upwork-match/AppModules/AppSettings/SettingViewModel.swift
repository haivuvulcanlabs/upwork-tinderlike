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
    @Published var isLoading: Bool = false
    
    let items: [AppSettingGroup] = AppSettingGroup.allCases
    func signOut() {
        do {
            isLoading = true
            try Auth.auth().signOut()
            isLoading = false
            PhoneViewModel.shared.clearSession()
            SessionManager.shared.saveUser(profile: nil)
            AppFlow.shared.isLoggedIn = false
        } catch {
            isLoading = false
        }
    }
}
