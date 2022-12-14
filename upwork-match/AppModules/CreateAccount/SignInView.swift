//
//  SignInView.swift
//  upwork-match
//
//  Created by vulcanlabs-hai on 07/12/2022.
//

import Foundation
import SwiftUI

struct SignInView: View {
    @State var selectedTab = 0
    var isLoginFlow = true //false = signup
    var body: some View {
        ZStack {
            VStack {
                BackButtonNavView(image: Image("ic-close-red"), text: "Sign in")
                
                TabView(selection: $selectedTab) {
                    InputPhoneNumberView(isLoginFlow: isLoginFlow, step: .inputPhone, tabIndex: $selectedTab).tag(0)
                    InputPhoneNumberView(isLoginFlow: isLoginFlow, step: .inputCode, tabIndex: $selectedTab).tag(1)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
            }
        }
        .myBackColor()
    }
}
