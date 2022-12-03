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
    
    func tappedContinueButton() {
        if step == .inputPhone {
            step = .inputCode
        }
    }
    
    func onVerifyCodeChanged(_ values: [String]) {
        
    }
}


enum SignInStep: Int, CaseIterable {
    case inputPhone = 0, inputCode
}

enum VerifyCodeField: Int, Hashable, CaseIterable {
    case num1 = 0, num2, num3, num4, num5, num6

}
