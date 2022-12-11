//
//  SplashScreeViewModel.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 30/11/2022.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class SplashScreeViewModel: ObservableObject {
    @Published var isDataLoaded = false
    @Published var isFullScreenCover = false
    static var shared = SplashScreeViewModel()

    func fetchAllAPI(completion: (()->())?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion?()
        }
        
        guard let currentUser = Auth.auth().currentUser else { return }
      
        AppFlow.shared.isLoggedIn  = true
//        000451.e81eed052aff45f9b8f83367b2c12162.0527
        
        debugPrint("hai - signin - \(currentUser.uid)")

        let db = Firestore.firestore()
        let ref = db.collection("/users/").document(currentUser.uid)
        ref.getDocument { snapshoot, error in
            if let document = snapshoot {
                
            }
        }
    }
}
