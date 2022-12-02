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
}


enum SignInStep: Int, CaseIterable {
    case inputPhone = 0, inputCode
}
