//
//  SignInViewModel.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 02/12/2022.
//

import Foundation
import SwiftUI
import FirebaseAuth

class SignInViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var isVerified: Bool = false
    @Published var phoneNumber: String = ""
    @Published var selectedCountry: Country = Country(phoneCode: "1", isoCode: "US")
    
    var verificationID: String?
    
    var phoneNumberWithCode: String {
        return "+\(selectedCountry.phoneCode + phoneNumber)"
    }
    
    
    func onVerifyPhoneNumber(completion: ((Bool)->())?) {
        let phoneNumberWithCode = "+\(selectedCountry.phoneCode + phoneNumber)"

        debugPrint("hai inputphone \(phoneNumberWithCode)")
        PhoneAuthProvider.provider()
          .verifyPhoneNumber(phoneNumberWithCode, uiDelegate: nil) { verificationID, error in
              if let error = error {
                  self.errorMessage = error.localizedDescription
                  debugPrint("hai inputphone \(error.localizedDescription)")
                  completion?(false)

                return
              }
              // Sign in using the verificationID and the code sent to the user
              // ...
              debugPrint("verificationID \(verificationID)")
              self.isVerified = true
              self.verificationID = verificationID
              UserDefaults.standard.set(verificationID, forKey: "authVerificationID")

              completion?(true)
              //
//                  AKf9Wb2X_YuhUVPqwj3ja_HbVAjAc3lG6RzVK6NiT0c2PebbJtEjlgmWFasSy5_eNGwVRGpiK4LCZvTQKOje_cpTnS68BZdE8JjcU7ZSp9BjFDBsPZUqqOsmSCCWK1xw-bpqtHF1C_n311EEzbvYqK2a75psB6fPOA
          }
    }
    
    func onVerifyCode(completion: ((Bool)->())?) {
        
        let verificationCode = "123456"
        guard let verificationID = verificationID else { return }
        let credential = PhoneAuthProvider.provider().credential(
          withVerificationID: verificationID,
          verificationCode: verificationCode
        )
        
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                self.isVerified = false
                completion?(false)

                return
            }
            // User is signed in
            // ...
            
            self.isVerified = true
            completion?(true)
        }
        
    }
    
    func onVerifyCodeChanged(_ values: [String]) {
        
        let codes = values.compactMap({Int($0) ?? -1})
        
        guard !codes.contains(-1) else {
            errorMessage = "The code you entered is invalid."
            return
        }
        
        isVerified = true
    }
    
    func onPhoneNumberChanged(_ newValue: String) {
        let phoneNumberWithCode = selectedCountry.phoneCode + newValue
        
        guard phoneNumberWithCode.isValidPhone else {
            errorMessage = "Invalid phone number"
            isVerified = false
            return
        }
        
        errorMessage = nil
        isVerified = true
    }
    
    func tappedResend() {
        
    }
    
    
}


enum SignInStep: Int, CaseIterable {
    case inputPhone = 0, inputCode
}

enum VerifyCodeField: Int, Hashable, CaseIterable {
    case num1 = 0, num2, num3, num4, num5, num6

}
