//
//  SignInViewModel.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 02/12/2022.
//

import Foundation
import SwiftUI
import FirebaseAuth

class PhoneViewModel: ObservableObject {
    static let shared = PhoneViewModel()
    
    @Published var errorMessage: String?
    @Published var isVerified: Bool = false
    @Published var phoneNumber: String = ""
    @Published var selectedCountry: Country = Country(phoneCode: "1", isoCode: "US")
    
    var verificationID: String?
    var verificationCode: String?

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
              //simulator
              //AKf9Wb3VZ4a_uqykN6RSIE63ZnLMohElQ_ywfIGU-aZBu20Us8Row9Zdselen5TQE7_gyrCDSzhS6UoSYapf6hQu35slswgcqzfqAcKPcpEkPtjmsJQm1-NSe-civDHCE4IkN2pLiH315faW4Z8GscAgJz1KnGYwXQ
          }
    }
    
    func onVerifyCode(completion: ((Bool)->())?) {
        
//        let verificationCode = "123456"
        
        guard let verificationCode = verificationCode else {
            return
        }

        guard let verificationID = verificationID else { return }
        
        let credential = PhoneAuthProvider.provider().credential(
          withVerificationID: verificationID,
          verificationCode: verificationCode
        )
        
        debugPrint("hai onVerifyCode")
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.isVerified = false
                completion?(false)

                return
            }
            // User is signed in
            // ...
            self.errorMessage = nil
            self.isVerified = true
            completion?(true)
        }
    }
    
    func onVerifyCodeChanged(_ values: [String]) {
        debugPrint("hai onVerifyCodeChanged")

        let codes = values.compactMap({Int($0) ?? -1})
        
        guard !codes.contains(-1) else {
            errorMessage = "The code you entered is invalid."
            isVerified = false
            return
        }
        errorMessage = nil
        isVerified = true
        
        verificationCode = values.joined()
    }
    
    func onPhoneNumberChanged(_ newValue: String) {
        debugPrint("hai onPhoneNumberChanged")

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
    
    func clearSession() {
        phoneNumber = ""
        selectedCountry = Country(phoneCode: "1", isoCode: "US")
        
        verificationID = nil
       verificationCode = nil
    }
}


enum SignInStep: Int, CaseIterable {
    case inputPhone = 0, inputCode
}

enum VerifyCodeField: Int, Hashable, CaseIterable {
    case num1 = 0, num2, num3, num4, num5, num6

}
