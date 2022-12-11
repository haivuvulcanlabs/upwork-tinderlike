//
//  CreateAccountViewModel.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 02/12/2022.
//

import Foundation
import SwiftUI
import AuthenticationServices
import CryptoKit
import FirebaseAuth
import FirebaseFirestore

class CreateAccountViewModel: NSObject, ObservableObject {
    @AppStorage(Defaults.userID) var userID = 0
    @AppStorage(Defaults.IsUserLogin) var isLogin = false
    @AppStorage(Defaults.authToken) var authToken = ""
    @AppStorage("stored_date") var storedDate = ""
    @Published var isLoading = false
    
    fileprivate var currentNonce: String?
    let db = Firestore.firestore()
    
    func signInWithApple() {
        let nonce = randomNonceString()
        currentNonce = nonce
        
        let provider = ASAuthorizationAppleIDProvider()
        
        let request = provider.createRequest()
        
        request.requestedScopes = [.fullName,.email]
        request.nonce = sha256(nonce)
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        
        
        controller.performRequests()
        controller.delegate = self
    }
}


extension CreateAccountViewModel: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        //        switch authorization.credential {
        //        case let credential as ASAuthorizationAppleIDCredential :
        //            self.isLoading = true
        //            let userID = credential.user
        //
        //            let email = credential.email
        //            let firstName = credential.fullName?.givenName
        //            let lastName = credential.fullName?.familyName
        //            let fullName = "\(firstName ?? "John") \(lastName ?? "Deo")"
        //            self.registerUser(username: email ?? userID, identity: userID, email: email ?? "\(userID)@apple.com", userFullname: fullName, loginType: LoginType.apple.rawValue)
        //
        //        default:
        //            break
        //        }
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            // Initialize a Firebase credential.
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            // Sign in with Firebase.
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if (error != nil) {
                    // Error. If error.code == .MissingOrInvalidNonce, make sure
                    // you're sending the SHA256-hashed nonce as a hex string with
                    // your request to Apple.
                    print(error?.localizedDescription)
                    return
                }
                // User is signed in to Firebase with Apple.
                // ...
                
                guard let user = authResult?.user else { return }

                let userID = appleIDCredential.user
//                000451.e81eed052aff45f9b8f83367b2c12162.0527
                debugPrint("hai - signin - \(userID)")
                let email =  appleIDCredential.email ?? "\(userID)@apple.com"
                let firstName = appleIDCredential.fullName?.givenName
                let lastName = appleIDCredential.fullName?.familyName
                let fullName = "\(firstName ?? "John") \(lastName ?? "Deo")"
                self.registerUser(username: email, identity: user.uid, email: email, userFullname: fullName, loginType: LoginType.apple.rawValue)
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func registerUser(username: String,identity: String, email: String, userFullname: String, loginType : Int) {
        let userName = String(username.split(separator: "@").first ?? "")
//        let oneSignalID = SessionManager.shared.getStringValueForKey(key: Defaults.oneSignalUUID)
//        let param = [Parameter.fullname : userFullname,
//                     Parameter.identity : identity,
//                     Parameter.loginType : "\(loginType)",
//                     Parameter.deviceToken : "WebServices.notificationToken",
//                     Parameter.deviceType : "2",
//                     Parameter.username : userName] as [String : Any]
        
        let user = UserProfile(id: identity, fullname: userFullname, username: username, email: email, profileImage: "", profileImages: [], loginType: loginType, identity: identity, deviceType: 2, deviceToken: "", bio: "", authToken: "")
        let ref = db.collection("/users/").whereField("identity", in: [identity])
        
        let newDocRef = db.collection("/users/").document(identity)
        ref.getDocuments { querysnapshot, errr in
            if let doc = querysnapshot?.documents, !doc.isEmpty {
               //"Document is present."
                AppFlow.shared.isLoggedIn = true

            } else {
                //
                newDocRef.setData(user.toJSON()) { error in
                    if let `error` = error {
                        debugPrint("create user \(error.localizedDescription)")
                    } else {
                        AppFlow.shared.isLoggedIn = true
                    }
                }
            }
        }
       
    }
}


extension CreateAccountViewModel {
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError(
                        "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                    )
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
}
enum LoginType : Int {
    case phone = 1
    case apple = 2
}
