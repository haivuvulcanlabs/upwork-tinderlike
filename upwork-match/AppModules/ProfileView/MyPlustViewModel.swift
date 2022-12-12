//
//  MyPlustViewModel.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 12/12/2022.
//

import Foundation
import SwiftUI

class MyPlustViewModel: NSObject, ObservableObject {
    
    @Published var plusSettings: [Bool] = [false, false, false, false, false, false]

    func getProfileSetting() {
        guard let profile = SessionManager.shared.profile else {
            return
        }
        
        let settings = profile.plusSetting
        plusSettings[0] = settings.unlimitedLike
        plusSettings[1] = settings.unlimitedMsg
        plusSettings[2] = settings.dontShowAge
        plusSettings[3] = settings.dontShowDistance
        plusSettings[4] = settings.hideMyProfile
    }
    
    func onUpdateSetting(at index: Int, value: Bool) {
        guard index < plusSettings.count else { return }
        plusSettings[index] = value
    }
    
}
