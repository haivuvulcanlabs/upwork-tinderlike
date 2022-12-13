//
//  FirebaseServices.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 12/12/2022.
//

import Foundation
import FirebaseFirestore

class FirebaseServices: NSObject {
    let db = Firestore.firestore()

    func registerUser(username: String,identity: String, userFullname: String, gender: Gender?, bio: String = "", bithday: String? = nil, age: Int? = nil, loginType : Int, completion: ((Bool)->())?) {
        let userName = String(username.split(separator: "@").first ?? "")
//        let oneSignalID = SessionManager.shared.getStringValueForKey(key: Defaults.oneSignalUUID)
//        let param = [Parameter.fullname : userFullname,
//                     Parameter.identity : identity,
//                     Parameter.loginType : "\(loginType)",
//                     Parameter.deviceToken : "WebServices.notificationToken",
//                     Parameter.deviceType : "2",
//                     Parameter.username : userName] as [String : Any]
        
        let user = UserProfile(id: identity, fullname: userFullname, username: username, profileImages: [], loginType: loginType, identity: identity, deviceType: 2, deviceToken: "", gender: gender, bio: bio, bithday: bithday, age: age, authToken: "", plusSetting: .default)
        let ref = db.collection("/users/").whereField("identity", in: [identity])
        
        let newDocRef = db.collection("/users/").document(identity)
        ref.getDocuments { querysnapshot, errr in
            if let doc = querysnapshot?.documents, !doc.isEmpty {
               //"Document is present."
                SessionManager.shared.saveUser(profile: user)
                completion?(true)
            } else {
                //
                newDocRef.setData(user.toJSON()) { error in
                    if let `error` = error {
                        debugPrint("create user \(error.localizedDescription)")
                        completion?(false)
                    } else {
                        SessionManager.shared.saveUser(profile: user)
                        completion?(true)
                    }
                }
            }
        }
    }
}
