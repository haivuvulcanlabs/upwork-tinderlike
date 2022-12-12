//
//  MyPlustViewModel.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 12/12/2022.
//

import Foundation
import SwiftUI
import FirebaseFirestore

class MyPlustViewModel: NSObject, ObservableObject {
    
    @Published var plusSettings: [Bool] = [false, false, false, false, false, false]
    @Published var isLoading: Bool = false
    
    let db = Firestore.firestore()
    
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
        guard var profile = SessionManager.shared.profile else { return }
        guard !isLoading else { return }
        isLoading = true
        var setting = profile.plusSetting
        switch index {
        case 0:
            setting.unlimitedLike = value
        case 1:
            setting.unlimitedMsg = value
        case 2:
            setting.dontShowAge = value
        case 3:
            setting.dontShowDistance = value
        case 4:
            setting.hideMyProfile = value
        default:
            break
        }
        guard let identity = profile.identity else {
            return
        }
        
       db.collection("/users/").document("\(identity)/").updateData(["plusSetting" : profile.plusSetting.toJSON()], completion: { error in
            self.isLoading = false
            if let error = error {
                
                return
            }
            
           self.plusSettings[index] = value
           profile.plusSetting = setting
           SessionManager.shared.saveUser(profile: profile)
        })

    }
    
}
