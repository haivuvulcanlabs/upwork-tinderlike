//
//  SignInViewModel.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 02/12/2022.
//

import Foundation
import SwiftUI


class SignInViewModel: ObservableObject {
    @Published var step: SignInStep = .inputPhone
    @Published var errorMessage: String?
    @Published var isVerified: Bool = false
    @Published var phoneNumber: String = ""
    @Published var selectedCountry: Country = Country(phoneCode: "1", isoCode: "US")

    func tappedContinueButton() {
        if step == .inputPhone {
            step = .inputCode
        } else {
            AppFlow.shared.isLoggedIn = true
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
