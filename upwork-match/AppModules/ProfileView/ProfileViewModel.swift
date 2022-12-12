//
//  ProfileViewModel.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 12/12/2022.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var profile: UserProfile?
    
    func reloadUserProfile() {
        profile = SessionManager.shared.profile
    }
}
